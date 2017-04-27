// varying
varying vec2 v_texCoord;
// uniform
uniform vec3 u_fog_color;
// main fragment
void main()
{
    vec4 pass1 = texture2D(CC_Texture0, v_texCoord*vec2(0.5, 1.0) + vec2(0.015, 0.0)*CC_Time[1]);

	gl_FragColor = vec4(u_fog_color, pass1.a);
}