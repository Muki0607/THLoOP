// --------------------------------------------------------------------------------
// 简化版海浪效果
// --------------------------------------------------------------------------------

SamplerState screen_texture_sampler : register(s4);
Texture2D screen_texture            : register(t4);
cbuffer engine_data : register(b1)
{
    float4 screen_texture_size;
    float4 viewport;
};

cbuffer user_data : register(b0)
{
    float4 wave_params;  // x:时间, y:波幅, z:频率, w:速度
    float4 wave_control; // x:强度, y:方向X, z:方向Y, w:细节强度
};

static const float PI = 3.14159265f;

struct PS_Input
{
    float4 sxy : SV_Position;
    float2 uv  : TEXCOORD0;
    float4 col : COLOR0;
};

struct PS_Output
{
    float4 col : SV_Target;
};

PS_Output main(PS_Input input)
{
    float time = wave_params.x;
    float amplitude = wave_params.y;
    float frequency = wave_params.z;
    float speed = wave_params.w;
    
    float intensity = wave_control.x;
    float2 direction = normalize(float2(wave_control.y, wave_control.z));
    float detail = wave_control.w;
    
    // 主波浪
    float wave1 = sin(dot(input.uv, direction) * frequency * 2.0 * PI + time * speed) * amplitude;
    
    // 细节波浪
    float wave2 = sin(dot(input.uv, direction * 1.5) * frequency * 4.0 * PI + time * speed * 1.3) * amplitude * 0.3;
    
    // 组合
    float total_wave = (wave1 + wave2 * detail) * intensity;
    
    // 应用UV偏移
    float2 wave_uv = input.uv;
    wave_uv.y += total_wave * 0.02;
    
    // 采样纹理
    float4 color = screen_texture.Sample(screen_texture_sampler, wave_uv);
    
    // 添加简单光照效果
    color.rgb *= 1.0 + total_wave * 0.2;
    
    PS_Output output;
    output.col = color;
    return output;
}