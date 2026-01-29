// ----------------------------------------
// inner_glow - Photoshop内发光效果
// by Muki feat. 通义千问
// ----------------------------------------

// 引擎设置的参数，不可修改
SamplerState screen_texture_sampler : register(s4); // RenderTarget 纹理的采样器
Texture2D screen_texture : register(t4); // RenderTarget 纹理
cbuffer engine_data : register(b1)
{
    float4 screen_texture_size; // 纹理大小 (width, height, 1/width, 1/height)
    float4 viewport;            // 视口
};

// 用户传递的浮点参数
cbuffer user_data : register(b0)
{
    float4 user_data_0;
    float4 user_data_1;
    float4 user_data_2;
};

// 参数定义
#define glow_color user_data_0.rgb  // 发光颜色 (RGB)
#define glow_opacity user_data_0.a  // 发光不透明度 (0-1)
#define glow_size user_data_1.x     // 发光大小 (像素)
#define glow_intensity user_data_1.y // 发光强度 (0-1)
#define glow_spread user_data_1.z   // 发光扩展 (0-1) - 控制发光扩散的范围和强度
#define glow_source user_data_1.w   // 发光源 (0:边缘, 1:中心)
#define glow_choke user_data_2.x    // 阻塞 (0-100)
#define glow_range user_data_2.y    // 发光范围 (0-100)
#define glow_noise user_data_2.z    // 杂色 (0-1)
#define glow_jitter user_data_2.w   // 抖动 (0-1)

// 结构体
struct PS_Input
{
    float4 sxy : SV_Position;
    float2 uv : TEXCOORD0;
    float4 col : COLOR0;
};

struct PS_Output
{
    float4 col : SV_Target;
};

// 简化的随机函数
float RandomSimple(float2 uv)
{
    return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
}

// 优化的边缘检测函数 - 减少纹理采样次数
float EdgeDetectionOptimized(float2 uv, float2 texelSize)
{
    float2 offset_x = float2(texelSize.x, 0.0);
    float2 offset_y = float2(0.0, texelSize.y);
    
    float c = screen_texture.SampleLevel(screen_texture_sampler, uv, 0).a;
    float l = screen_texture.SampleLevel(screen_texture_sampler, uv - offset_x, 0).a;
    float r = screen_texture.SampleLevel(screen_texture_sampler, uv + offset_x, 0).a;
    float t = screen_texture.SampleLevel(screen_texture_sampler, uv - offset_y, 0).a;
    float b = screen_texture.SampleLevel(screen_texture_sampler, uv + offset_y, 0).a;
    
    // 简化的Sobel算子
    float gx = r - l;
    float gy = b - t;
    
    return sqrt(gx * gx + gy * gy);
}

// 优化的高斯模糊 - 分离核实现，提高性能
float4 GaussianBlurOptimized(float2 uv, float radius, float2 texelSize, float spread, float sourceType)
{
    float4 color = float4(0, 0, 0, 0);
    float totalWeight = 0.0;
    
    // 使用较小的核半径，提高性能
    // 将spread参数融入radius计算中，控制模糊范围
    float effectiveRadius = max(radius * spread, 1.0);
    int intEffectiveRadius = min(int(ceil(effectiveRadius)), 5);
    
    // 分离核：先水平方向，再垂直方向
    // 水平方向
    for (int i = -intEffectiveRadius; i <= intEffectiveRadius; i++)
    {
        float weight = exp(-(i * i) / (2.0 * effectiveRadius * effectiveRadius));
        float2 offset = float2(i * texelSize.x, 0);
        float4 sampleColor = screen_texture.Sample(screen_texture_sampler, uv + offset);
        
        // 根据发光源类型处理
        float alphaValue = (sourceType < 0.5) ? 
            EdgeDetectionOptimized(uv + offset, texelSize) : // 边缘作为光源
            (1.0 - sampleColor.a); // 中心作为光源
            
        color += float4(glow_color, alphaValue) * weight;
        totalWeight += weight;
    }
    
    // 归一化第一次结果
    if (totalWeight > 0)
    {
        color /= totalWeight;
    }
    
    // 垂直方向
    float4 tempResult = color;
    color = float4(0, 0, 0, 0);
    totalWeight = 0.0;
    
    for (int i = -intEffectiveRadius; i <= intEffectiveRadius; i++)
    {
        float weight = exp(-(i * i) / (2.0 * effectiveRadius * effectiveRadius));
        float2 offset = float2(0, i * texelSize.y);
        
        float4 tempSample = screen_texture.Sample(screen_texture_sampler, uv + offset);
        float alphaValue = (sourceType < 0.5) ? 
            EdgeDetectionOptimized(uv + offset, texelSize) : 
            (1.0 - tempSample.a);
            
        color += float4(tempResult.rgb, alphaValue) * weight;
        totalWeight += weight;
    }
    
    // 最终归一化
    if (totalWeight > 0)
    {
        color /= totalWeight;
    }
    
    return color;
}


// 主函数
PS_Output main(PS_Input input)
{
    // 获取像素的真实位置
    float2 uv = input.uv;
    float2 xy = uv * screen_texture_size.xy;
    
    // 检查是否在视口范围内
    if (xy.x < viewport.x || xy.x > viewport.z || xy.y < viewport.y || xy.y > viewport.w)
    {
        discard;
    }
    
    // 计算纹素大小
    float2 texelSize = float2(1.0 / screen_texture_size.x, 1.0 / screen_texture_size.y);
    
    // 获取原始颜色
    float4 originalColor = screen_texture.SampleLevel(screen_texture_sampler, uv, 0);
    
    // 生成发光遮罩 - 始终使用柔和技术
    float glowMask = 0.0;
    
    // 使用优化版高斯模糊
    float4 blurred = GaussianBlurOptimized(uv, max(glow_size * 0.5, 1.0), texelSize, glow_spread, glow_source);
    glowMask = blurred.a * glow_intensity;
    
    // 添加杂色效果 - 仅在需要时计算
    if (glow_noise > 0.0)
    {
        float noise = RandomSimple(uv + float2(glow_jitter, 0));
        glowMask *= lerp(1.0, noise, glow_noise);
    }
    
    // 计算发光颜色
    float4 glowColor = float4(glow_color, glowMask * glow_opacity);
    
    // 混合模式：正常混合（alpha blending）
    // 内发光应该只在原始图像的内部或透明区域显示
    float alphaFactor = (glow_source < 0.5) ? (1.0 - originalColor.a) : 1.0; // 对于内发光，通常在透明区域显示
    
    // 混合发光效果
    float4 finalColor;
    finalColor.rgb = lerp(originalColor.rgb, glowColor.rgb, glowColor.a * alphaFactor);
    finalColor.a = originalColor.a;
    
    PS_Output output;
    output.col = finalColor;
    return output;
}

// Lua侧调用示例：
/*
lstg.LoadFX("inner_glow_simple", "inner_glow_simple.hlsl")

lstg.PostEffect("inner_glow_simple", "screen", 6, "mul+alpha",
    -- 浮点参数
    {
        -- user_data_0: 发光颜色(R,G,B)和不透明度(A)
        { 1.0, 0.8, 0.2, 0.8 },  -- 金色发光，80%不透明度
        
        -- user_data_1: 发光参数
        { 10.0, 0.8, 0.5, 0.0 }, -- 大小10像素，强度80%，扩展50%，光源=边缘
        
        -- user_data_2: 高级参数
        { 0.0, 50.0, 0.0, 0.0 }, -- 阻塞0%，范围50%，无杂色，无抖动
    },
)
*/