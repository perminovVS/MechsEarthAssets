// varying
varying vec2 v_texCoord;
#ifndef SETTINGS_DISABLE_FOG
varying float v_fogFactor;
uniform vec3 u_fog_color;
#endif
// uniform
uniform vec4 u_color;
uniform sampler2D u_Blend;
uniform sampler2D u_Detail;
uniform float u_DetailUV;
// main fragment
void main()
{
    gl_FragColor = texture2D(CC_Texture0, v_texCoord);
	
    vec4 blendFactor = texture2D(u_Blend, v_texCoord);
	gl_FragColor = vec4(mix(gl_FragColor.rgb, blendFactor.rgb, blendFactor.a), 1.0);
	
	gl_FragColor += (texture2D(u_Detail, v_texCoord*u_DetailUV) - 0.5);

#ifndef SETTINGS_DISABLE_FOG
	if( v_fogFactor < 1.0 )
	{
		gl_FragColor.rgb = (gl_FragColor * v_fogFactor + vec4(u_fog_color * (1.0 - v_fogFactor), 1.0)).rgb;
	}
#endif
}