// --------------------------------------------------------------------------------
// 简化版中心缩放效果
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
    float4 main_params;    // x: 缩放强度, y: 内半径, z: 外半径, w: 时间
    float4 center_point;   // xy: 中心点, z: 发光强度, w: 过渡平滑度
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
    PS_Output output;
    // 参数
    float scale_intensity = main_params.x;
    float r2 = main_params.y;
    float r1 = main_params.z;
    float time = main_params.w;
    
    float2 center = center_point.xy;
    float glow_intensity = center_point.z;
    float smoothness = center_point.w;
    
    // 计算宽高比
    float aspect_ratio = screen_texture_size.x / screen_texture_size.y;
    
    // 计算调整后的距离
    float2 uv_centered = input.uv - center;
    uv_centered.x *= aspect_ratio;
    float r = length(uv_centered);

    // 计算缩放因子
    float scale;
    if (r < r2)
    {
        scale = 1.0;
    }
    else if (r < r1/2 + r2/2)
    {
        float t = smoothstep(r2, r1/2 + r2/2, r);
        scale = lerp(1.0, 1.0 + scale_intensity, t);
    }
    else if (r < r1)
    {
        float t = smoothstep(r1/2 + r2/2, r1, r);
        scale = lerp(1.0 + scale_intensity, 1.0, t);
    }
    else
    {
        scale = 1.0;
    }
    
    // 计算缩放后的UV
    uv_centered = uv_centered / scale;
    uv_centered.x /= aspect_ratio;
    float2 scaled_uv = center + uv_centered;
    
    // 采样纹理
    float4 color = screen_texture.Sample(screen_texture_sampler, scaled_uv);
    
    if (scale_intensity < 0.00001){
        output.col = color;
        return output;
    }
    // 计算发光强度
    float glow = saturate((scale - 1.0)/(scale_intensity + 0.1)) * glow_intensity;
    
    // 应用发光效果
    color.r *= 1.0 + glow*2;
    color.g *= 1.0 + glow;
    color.b *= 1.0 + glow;
    
    // 添加脉动效果
    float pulse = 0.5 + 0.5 * sin(time * PI);
    color.rgb += pulse * glow * 0.2;
    
    output.col = color;
    return output;
}