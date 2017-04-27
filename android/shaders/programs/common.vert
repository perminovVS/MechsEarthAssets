// attribute
attribute vec4 a_position;
attribute vec2 a_texCoord;
// uniform
#ifdef COMPILE_WITH_UV_TRANSFORMATION
uniform mat4 u_texCoordMod;
#endif
// varying
varying vec2 v_texCoord;

#ifndef COMPILE_WITHOUT_FOG
varying float v_fogFactor;
uniform vec3 u_eye_mv;
// u_fog_distance_squared.x = fogStartSquared
// u_fog_distance_squared.y = fogEndSquared
uniform vec2 u_fog_distance_squared;
#endif
// main vertex
void main()
{
    gl_Position = CC_MVPMatrix * a_position;

#ifdef COMPILE_WITH_UV_TRANSFORMATION
    v_texCoord = (u_texCoordMod*vec4(a_texCoord, 1.0, 1.0)).xy;
#else
    v_texCoord = a_texCoord;
#endif

#ifndef COMPILE_WITHOUT_FOG
	vec3 distanceVectorToEye = (CC_MVMatrix * a_position).xyz - u_eye_mv;
    float distanceToEyeSquared = distanceVectorToEye.x*distanceVectorToEye.x + distanceVectorToEye.y*distanceVectorToEye.y + distanceVectorToEye.z*distanceVectorToEye.z;
    
	v_fogFactor = (distanceToEyeSquared - u_fog_distance_squared.x) / (u_fog_distance_squared.y - u_fog_distance_squared.x);
	v_fogFactor = 1.0 - clamp(v_fogFactor, 0.0, 1.0);
#endif
}