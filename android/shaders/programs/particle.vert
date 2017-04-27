
// attribute
attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute float a_color; // alpha
// uniform
#ifdef COMPILE_WITH_PARTICLE_UV_TRANSFORMATION
uniform mat4 u_texCoordMod;
#endif
// varying
varying vec2 v_texCoord;
varying float v_alpha;
// main vertex
void main()
{
    gl_Position = CC_MVPMatrix * a_position;
    
#ifdef COMPILE_WITH_PARTICLE_UV_TRANSFORMATION
        v_texCoord = (u_texCoordMod*vec4(a_texCoord, 1.0, 1.0)).xy;
#else
        v_texCoord = a_texCoord;
#endif

	v_alpha = a_color;
}