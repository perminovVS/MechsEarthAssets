
// varying
varying vec2 v_texCoord;
#ifndef COMPILE_WITHOUT_FOG
varying float v_fogFactor;
uniform vec3 u_fog_color;
#endif
// uniform
#ifdef COMPILE_WITH_COLOR
uniform vec4 u_color;
#endif
#ifdef COMPILE_WITH_DETAIL
uniform sampler2D u_Detail;
uniform float u_DetailUV;
#endif
#ifdef COMPILE_WITH_BLEND
uniform sampler2D u_Blend;
#endif
// main fragment
void main()
{
    gl_FragColor = texture2D(CC_Texture0, v_texCoord);

#ifdef COMPILE_WITH_COLOR
	gl_FragColor = gl_FragColor*u_color;
#endif

#ifdef COMPILE_WITH_BLEND
    vec4 blendFactor = texture2D(u_Blend, v_texCoord);
	gl_FragColor = vec4(mix(gl_FragColor.rgb, blendFactor.rgb, blendFactor.a), 1.0);
#endif

#ifdef COMPILE_WITH_DETAIL
	gl_FragColor += (texture2D(u_Detail, v_texCoord*u_DetailUV) - 0.5);
    
	#ifndef COMPILE_WITH_MAX_OPTIMIZATION
	gl_FragColor += (texture2D(u_Detail, v_texCoord*u_DetailUV*10.0) - 0.5);
	#endif
#endif
    
#ifndef COMPILE_WITHOUT_FOG
	gl_FragColor.rgb = (gl_FragColor * v_fogFactor + vec4(u_fog_color * (1.0 - v_fogFactor), 1.0)).rgb;
#endif
}