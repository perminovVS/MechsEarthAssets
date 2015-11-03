
// varying
varying vec2 v_texCoord;
#ifndef SETTINGS_DISABLE_FOG
varying float v_fogFactor;
uniform vec3 u_fog_color;
#endif
// uniform
uniform vec4 u_color;
// main fragment
void main()
{
    gl_FragColor = u_color*texture2D(CC_Texture0, v_texCoord);
    
#ifndef SETTINGS_DISABLE_FOG
	if( v_fogFactor < 1.0 )
	{
		gl_FragColor.rgb = (gl_FragColor * v_fogFactor + vec4(u_fog_color * (1.0 - v_fogFactor), 1.0)).rgb;
	}
#endif
}