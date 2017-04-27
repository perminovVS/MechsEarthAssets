
// attribute
attribute vec4 a_position;
attribute vec2 a_texCoord;
// varying
varying vec2 v_texCoord;

#ifndef COMPILE_WITHOUT_FOG
// varying
varying float v_fogFactor;
// uniform
uniform vec3 u_eye_mv;
// u_fog_distance_squared.x = fogStartSquared
// u_fog_distance_squared.y = fogEndSquared
uniform vec2 u_fog_distance_squared;
#endif

// main vertex
void main()
{
	gl_Position = CC_MVPMatrix * a_position;
	v_texCoord = a_texCoord;
    
#ifndef COMPILE_WITHOUT_FOG
    v_fogFactor = 1.1;
    if (u_fog_distance_squared.x > 0.0)
    {
        vec3 distanceVector = (CC_MVMatrix * a_position).xyz - u_eye_mv;
        float distanceEyeSquared = distanceVector.x*distanceVector.x + distanceVector.y*distanceVector.y + distanceVector.z*distanceVector.z;
        if (distanceEyeSquared > u_fog_distance_squared.x)
        {
            if (distanceEyeSquared > u_fog_distance_squared.y)
            {
                v_fogFactor = 0.0;
            }
            else
            {
                v_fogFactor = (distanceEyeSquared - u_fog_distance_squared.x) / (u_fog_distance_squared.y - u_fog_distance_squared.x);
                v_fogFactor = 1.0 - clamp(v_fogFactor, 0.0, 1.0);
            }
        }
    }
#endif
}