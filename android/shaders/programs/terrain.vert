
// attribute
attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute float a_fogFactor;
// varying
varying vec2 v_texCoordMain;
varying vec2 v_texCoordDetail;
varying float distanceToEyeSquared;

#ifndef SETTINGS_DISABLE_FOG
varying float v_fogFactor;
#endif

#ifndef SETTINGS_IS_MAX_OPTIMIZATION
varying float v_DistanceCameraSquared;
varying float v_DistanceToEyeZSquared;
uniform vec3 u_camera;
#endif

// uniform
uniform float u_uv_scale;
uniform float u_eye_delta;
uniform vec3 u_eye;
void main()
{
    gl_Position = CC_MVPMatrix * a_position;
    v_texCoordMain = a_texCoord;
    v_texCoordDetail = a_texCoord*u_uv_scale;
    
#ifndef SETTINGS_DISABLE_FOG 
    v_fogFactor = a_fogFactor;
#endif
    
	vec2 distanceVectorToEye = a_position.xy - u_eye.xy;
    distanceToEyeSquared = distanceVectorToEye.x*distanceVectorToEye.x + distanceVectorToEye.y*distanceVectorToEye.y;
    
#ifndef SETTINGS_IS_MAX_OPTIMIZATION 
	v_DistanceToEyeZSquared = a_position.z - u_eye.z;


	vec3 distanceVector = a_position.xyz - u_camera;
	v_DistanceCameraSquared = distanceVector.x*distanceVector.x + distanceVector.y*distanceVector.y + distanceVector.z*distanceVector.z;
#endif
}