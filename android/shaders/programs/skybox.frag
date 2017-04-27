// varying
varying vec2 v_texCoord;
// uniform
uniform vec3 u_fog_color;
uniform float u_start_time_s;
// main fragment
void main()
{	
    gl_FragColor = texture2D(CC_Texture0, v_texCoord + vec2(0.0003, 0.0)*CC_Time[1]);
    
    float blendFactor = u_start_time_s;
	if( blendFactor < 1.0 )
	{
        vec4 blendColor = texture2D(CC_Texture1, v_texCoord + vec2(0.0003, 0.0)*CC_Time[1]);
		gl_FragColor = gl_FragColor * blendFactor + blendColor * (1.0 - blendFactor);
	}
}