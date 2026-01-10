// 引擎参数
SamplerState screen_texture_sampler : register(s4); // RenderTarget 纹理的采样器
Texture2D screen_texture            : register(t4); // RenderTarget 纹理
cbuffer engine_data : register(b1)
{
    float4 screen_texture_size; // 纹理大小
    float4 viewport;            // 视口
};

// 用户传递的参数
cbuffer user_data : register(b0)
{
    float4 center_pos;   // 黑洞中心坐标
    float4 effect_color; // 吸积盘颜色
    float4 effect_param; // 参数：effect_size 事件视界大小、effect_arg 引力强度、effect_color_size 吸积盘大小、timer 计时器
};

#define effect_size       effect_param.x
#define effect_arg        effect_param.y
#define effect_color_size effect_param.z
#define timer             effect_param.w

// 不变量
static const float PI = 3.14159265f;
static const float GRAVITY_CONST = 6.67430e-11f; // 引力常数（用于计算偏移）
static const float EVENT_HORIZON_RATIO = 0.5f;   // 事件视界与影响半径的比例

// 方法：计算引力透镜偏移
float2 GravitationalLens(float2 delta, float delta_len)
{
    // 计算史瓦西半径偏移（模拟引力透镜效应）
    float schwarzschild_radius = effect_size * EVENT_HORIZON_RATIO;
    float impact_parameter = delta_len;
    
    // 当光线接近事件视界时，产生强烈的偏折
    if (delta_len > schwarzschild_radius)
    {
        // 爱因斯坦环效应：光线偏折角度 = 4GM/(c² * b)
        // 简化版本使用反平方关系
        float deflection = effect_arg * (schwarzschild_radius * schwarzschild_radius) / 
                          (delta_len * delta_len + 0.001f);
        
        // 添加旋转效果模拟克尔黑洞
        float rotation_speed = 0.05f * timer;
        float cos_rot = cos(rotation_speed);
        float sin_rot = sin(rotation_speed);
        float2 rotation_matrix = float2(
            delta.x * cos_rot - delta.y * sin_rot,
            delta.x * sin_rot + delta.y * cos_rot
        );
        
        // 返回偏移向量（朝向黑洞中心）
        return -deflection * normalize(rotation_matrix) * (1.0f + 0.3f * sin(0.5f * timer));
    }
    else
    {
        // 在事件视界内，产生漩涡效果
        float swirl_intensity = 5.0f * (1.0f - delta_len / schwarzschild_radius);
        float angle = atan2(delta.y, delta.x) + swirl_intensity + 0.1f * timer;
        float radius = delta_len * (0.5f + 0.5f * sin(0.3f * timer));
        
        return float2(radius * cos(angle) - delta.x, 
                     radius * sin(angle) - delta.y);
    }
}

// 方法：计算吸积盘颜色
float4 CalculateAccretionDisk(float2 delta, float delta_len, float4 original_color)
{
    float accretion_radius = effect_color_size;
    float event_horizon = effect_size * EVENT_HORIZON_RATIO;
    
    if (delta_len > event_horizon && delta_len < accretion_radius)
    {
        // 吸积盘分层效果
        float ring_thickness = accretion_radius - event_horizon;
        float normalized_dist = (delta_len - event_horizon) / ring_thickness;
        
        // 多层环状结构
        float ring1 = smoothstep(0.0f, 0.3f, normalized_dist) * 
                     smoothstep(0.5f, 0.3f, normalized_dist);
        float ring2 = smoothstep(0.4f, 0.6f, normalized_dist) * 
                     smoothstep(0.9f, 0.6f, normalized_dist);
        float ring3 = smoothstep(0.7f, 0.85f, normalized_dist);
        
        // 动态旋转效果
        float rotation_angle = atan2(delta.y, delta.x);
        float time_factor = timer * 0.02f;
        float spiral1 = sin(rotation_angle * 3.0f + time_factor * 2.0f + delta_len * 0.1f);
        float spiral2 = cos(rotation_angle * 5.0f + time_factor * 3.0f - delta_len * 0.08f);
        
        // 计算吸积盘亮度
        float accretion_brightness = 0.8f * (ring1 + 0.7f * ring2 + 0.5f * ring3) * 
                                   (0.7f + 0.3f * (spiral1 * spiral2));
        
        // 径向颜色渐变（内部更蓝，外部更红）
        float4 inner_color = float4(0.2f, 0.4f, 1.0f, 1.0f); // 蓝色（高温）
        float4 outer_color = float4(1.0f, 0.3f, 0.1f, 1.0f); // 红色（低温）
        
        float4 accretion_color = lerp(inner_color, outer_color, normalized_dist);
        accretion_color.rgb *= accretion_brightness;
        
        // 添加热斑效果
        float hotspot = sin(rotation_angle * 8.0f + timer * 0.05f) * 0.5f + 0.5f;
        accretion_color.rgb += float3(1.0f, 0.8f, 0.3f) * hotspot * ring2 * 0.3f;
        
        // 与原始颜色混合
        float blend_factor = smoothstep(event_horizon, accretion_radius, delta_len);
        blend_factor *= smoothstep(accretion_radius, event_horizon, delta_len);
        
        return lerp(original_color, accretion_color, blend_factor * effect_color.a);
    }
    
    return original_color;
}

// 方法：计算引力红移
float4 CalculateGravitationalRedshift(float2 delta, float delta_len, float4 color)
{
    float event_horizon = effect_size * EVENT_HORIZON_RATIO;
    
    if (delta_len < effect_color_size)
    {
        // 引力红移：靠近黑洞时光线波长变长（颜色偏红）
        float redshift_intensity = 1.0f - smoothstep(0.0f, event_horizon, delta_len);
        
        // 红色通道增强，蓝色通道减弱
        color.r = min(1.0f, color.r + redshift_intensity * 0.3f);
        color.b = max(0.0f, color.b - redshift_intensity * 0.4f);
        
        // 整体变暗（部分光线被黑洞捕获）
        color.rgb *= 1.0f - redshift_intensity * 0.2f;
    }
    
    return color;
}

// 主函数
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
    float2 xy = input.uv * screen_texture_size.xy;  // 屏幕上真实位置
    if (xy.x < viewport.x || xy.x > viewport.z || xy.y < viewport.y || xy.y > viewport.w)
    {
        discard; // 抛弃不需要的像素，防止意外覆盖画面
    }
    
    float2 uv2 = input.uv;
    float2 delta = xy - center_pos.xy;  // 计算黑洞中心到纹理采样点的向量
    float delta_len = length(delta);
    
    // 只在影响范围内处理
    if (delta_len <= effect_color_size)
    {
        // 计算引力透镜偏移
        float2 distortion = GravitationalLens(delta, delta_len);
        float2 resultxy = xy + distortion;
        
        // 确保偏移后的坐标在视口内
        if (resultxy.x > viewport.x && resultxy.x < viewport.z && 
            resultxy.y > viewport.y && resultxy.y < viewport.w)
        {
            uv2 += distortion / screen_texture_size.xy;
        }
    }
    
    // 采样纹理
    float4 tex_color = screen_texture.Sample(screen_texture_sampler, uv2);
    
    // 应用吸积盘效果
    tex_color = CalculateAccretionDisk(delta, delta_len, tex_color);
    
    // 应用引力红移
    tex_color = CalculateGravitationalRedshift(delta, delta_len, tex_color);
    
    // 事件视界效果（完全黑暗）
    float event_horizon = effect_size * EVENT_HORIZON_RATIO;
    if (delta_len <= event_horizon)
    {
        // 添加微弱的辉光效果
        float glow = 0.05f * sin(timer * 0.1f + delta_len * 10.0f) + 0.95f;
        tex_color.rgb = float3(0.0f, 0.0f, 0.0f) * glow;
    }
    
    // 光子球效果（爱因斯坦环）
    float photon_sphere = event_horizon * 1.5f;
    if (abs(delta_len - photon_sphere) < 2.0f)
    {
        float ring_intensity = 0.5f + 0.5f * sin(timer * 0.3f);
        tex_color.rgb += float3(1.0f, 0.9f, 0.5f) * ring_intensity * 
                        smoothstep(2.0f, 0.0f, abs(delta_len - photon_sphere));
    }
    
    tex_color.a = 1.0f;
    
    PS_Output output;
    output.col = tex_color;
    return output;
}