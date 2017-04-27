
// attribute
attribute vec4 a_position;
attribute vec2 a_texCoord;
// varying
varying vec2 v_texCoordMain;
varying vec2 v_texCoordDetail;
varying float v_distanceToEyeSquared;

#ifndef COMPILE_WITHOUT_FOG
varying float v_fogFactor;
varying float v_fogFactorDiscard;
// u_fog_distance_squared.x = fogStartSquared
// u_fog_distance_squared.y = fogEndSquared
uniform vec2 u_fog_distance_squared;
#endif

#ifndef COMPILE_WITH_MAX_OPTIMIZATION
varying float v_DistanceCameraSquared;
varying float v_DistanceToEyeZSquared;
uniform vec3 u_camera;
#endif

// uniform
uniform float u_uv_scale;
uniform vec3 u_eye;
void main()
{
    gl_Position = CC_MVPMatrix * a_position;
    v_texCoordMain = a_texCoord;
    v_texCoordDetail = a_texCoord*u_uv_scale;
    
	vec2 distanceVectorToEye = a_position.xy - u_eye.xy;
    float distanceToEyeSquared = (distanceVectorToEye.x*distanceVectorToEye.x + distanceVectorToEye.y*distanceVectorToEye.y);	
    
#ifndef COMPILE_WITHOUT_FOG
	float distanceToEyeSquaredX = distanceVectorToEye.x*distanceVectorToEye.x;
	float distanceToEyeSquaredY = distanceVectorToEye.y*distanceVectorToEye.y;

	float distanceSquaredFog = u_fog_distance_squared.y - u_fog_distance_squared.x;
	v_fogFactorDiscard = max((distanceToEyeSquaredX - u_fog_distance_squared.x) / distanceSquaredFog, (distanceToEyeSquaredY - u_fog_distance_squared.x) / distanceSquaredFog);
	//v_fogFactor = (distanceToEyeSquared - u_fog_distance_squared.x) / distanceSquaredFog;
	v_fogFactor = 1.0 - clamp(v_fogFactorDiscard + 0.35, 0.0, 1.0);
#endif
	// GL ES fragment programm no support big number in varying
	v_distanceToEyeSquared = distanceToEyeSquared*0.001;
    
#ifndef COMPILE_WITH_MAX_OPTIMIZATION 

	v_DistanceToEyeZSquared = a_position.z - u_eye.z;


	vec3 distanceVector = a_position.xyz - u_camera;
	v_DistanceCameraSquared = distanceVector.x*distanceVector.x + distanceVector.y*distanceVector.y + distanceVector.z*distanceVector.z;
#endif
}