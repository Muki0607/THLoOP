//======================================
// coloring - 油漆桶着色器
// from 着色器从入门到放弃治疗.docx
// 代码移植 by Muki
// 借助dpsk之力从fx改写成了hlsl
//======================================

// 引擎设置的参数，不可修改

SamplerState screen_texture_sampler : register(s4); // RenderTarget 纹理的采样器
Texture2D screen_texture            : register(t4); // RenderTarget 纹理
cbuffer engine_data : register(b1)
{
    float4 screen_texture_size; // 纹理大小
    float4 viewport;            // 视口
};

// 用户传递的浮点参数
// 由多个 float4 组成，且 float4 是最小单元，最多可传递 8 个 float4

cbuffer user_data : register(b0)
{
    float4 user_data_0;    // R, G, B, A 分量 (0-255范围)
};

#define color_A    user_data_0.x
#define color_R    user_data_0.y
#define color_G    user_data_0.z
#define color_B    user_data_0.w

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
    // 获取原始像素颜色
    float4 tex_col = screen_texture.Sample(screen_texture_sampler, input.uv);
    
    // 获取原始透明度
    float original_alpha = tex_col.a;
    
    // 计算最终颜色
    float4 final_color;
    
    // 如果A < 0，则不改变透明度
    if (color_A < 0.0f)
    {
        final_color = float4(color_R / 255.0f, 
                            color_G / 255.0f, 
                            color_B / 255.0f, 
                            original_alpha);
    }
    else
    {
        // 计算新的透明度
        float new_alpha = original_alpha * (color_A / 255.0f);
        final_color = float4(color_R / 255.0f, 
                            color_G / 255.0f, 
                            color_B / 255.0f, 
                            new_alpha);
    }
    
    PS_Output output;
    output.col = final_color;
    return output;
}

// Lua侧调用示例：
/*
lstg.LoadFX("coloring", "coloring.hlsl")

lstg.PostEffect("coloring", "screen", 6, "mul+alpha",
    -- 浮点参数
    {
        { 255.0, 0.0, 0.0, 255.0 },    -- ARGB分量 (0-255范围)
    },
)
*/