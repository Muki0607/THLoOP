// 黑白二值化特效
// 适用于luastg+

// 由PostEffect过程捕获到的纹理
texture2D ScreenTexture:POSTEFFECTTEXTURE;  // 纹理
sampler2D ScreenTextureSampler = sampler_state {  //` 采样器
    texture = <ScreenTexture>;
    AddressU  = BORDER;
    AddressV = BORDER;
    Filter = MIN_MAG_LINEAR_MIP_POINT;
};

// 自动设置的参数
float4 screen : SCREENSIZE;  // 屏幕缓冲区大小

float4 PS_MainPass(float4 position:POSITION, float2 uv:TEXCOORD0):COLOR
{
    float2 screenSize = float2(screen.z - screen.x, screen.w - screen.y);
    float2 uvReal = uv * screenSize;  // 屏幕上真实位置
    float4 texColor;
	float  colorsum;
	texColor = tex2D(ScreenTextureSampler, uv);
	colorsum = (texColor.r+texColor.g+texColor.b)/3;
	
	texColor.r = colorsum;
	texColor.g = colorsum;
	texColor.b = colorsum;
	
    return texColor;
}


technique Main
{
    pass MainPass
    {
        PixelShader = compile ps_3_0 PS_MainPass();
    }
}
