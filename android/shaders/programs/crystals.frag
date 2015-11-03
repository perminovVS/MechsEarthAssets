varying vec2 v_texCoord;
#ifndef SETTINGS_DISABLE_FOG
varying float v_fogFactor;
uniform vec3 u_fog_color;
#endif
void main()
{
    gl_FragColor = texture2D(CC_Texture0, v_texCoord + vec2(-0.3, 0.0)*CC_Time[1]) + texture2D(CC_Texture1, v_texCoord*2.0);

#ifndef SETTINGS_DISABLE_FOG
	if( v_fogFactor < 1.0 )
	{
		gl_FragColor.rgb = (gl_FragColor * v_fogFactor + vec4(u_fog_color * (1.0 - v_fogFactor), 1.0)).rgb;
	}
#endif
}