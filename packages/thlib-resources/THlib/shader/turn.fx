// 由PostEffect过程捕获到的纹理
texture2D ScreenTexture:POSTEFFECTTEXTURE;  // 纹理
sampler2D ScreenTextureSampler = sampler_state {  // 采样器
    texture = <ScreenTexture>;
    AddressU  = BORDER;
    AddressV = BORDER;
    Filter = MIN_MAG_LINEAR_MIP_POINT;
};

// 自动设置的参数
float4 screen : SCREENSIZE;  // 屏幕缓冲区大小

// 外部参数
float centerX < string binding = "centerX"; > = 100.0f;  // 指定效果的中心坐标X
float centerY < string binding = "centerY"; > = 100.0f;  // 指定效果的中心坐标Y
float angle < string binding = "angle"; > = 0.0f;

float4 PS_MainPass(float4 position:POSITION, float2 uv:TEXCOORD0):COLOR
{
	float rot=radians(angle);
    float2 screenSize = float2(screen.z - screen.x, screen.w - screen.y);
	float2 trans=float2(cos(rot),sin(rot));
    float2 center = float2(centerX, centerY);
    float2 xy = uv * screenSize;  // 屏幕上真实位置
	float2 delta=xy-center;
	float2 xy2= float2(delta.x*trans[0]-delta.y*trans[1],delta.x*trans[1]+delta.y*trans[0])+center;
	
	uv=xy2/screenSize;
    
    // 对纹理进行采样
    float4 texColor = tex2D(ScreenTextureSampler, uv);
 
    texColor.a = 1;
    return texColor;
}

technique Main
{
    pass MainPass
    {
        PixelShader = compile ps_3_0 PS_MainPass();
    }
}
