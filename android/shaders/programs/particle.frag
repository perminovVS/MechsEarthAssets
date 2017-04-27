
// varying
varying vec2 v_texCoord;
varying float v_alpha;
// uniform
uniform vec4 u_color;
// main fragment
void main()
{
    gl_FragColor = u_color*texture2D(CC_Texture0, v_texCoord);
	
#ifdef COMPILE_WITH_PARTICLE_FADE_ALPHA
	gl_FragColor.a = gl_FragColor.a*v_alpha;
#endif
#ifdef COMPILE_WITH_PARTICLE_FADE_RGB
	gl_FragColor.rgb = gl_FragColor.rgb*v_alpha;
#endif
}