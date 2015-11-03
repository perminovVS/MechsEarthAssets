
#ifndef SETTINGS_DISABLE_FOG
// varying
varying float v_fogFactor;
// uniform
uniform vec3 u_eye_mv;
uniform vec2 u_fog_distance_squared;
// declarations
void UpdateFogFactor()
{
	if(u_fog_distance_squared.x > 0.0)
	{    
	    float fogStartSquared = u_fog_distance_squared.x;
	    float fogEndSquared = u_fog_distance_squared.y;
        vec3 v_PositionMV = (CC_MVMatrix * a_position).xyz;
		vec3 distanceVector = v_PositionMV - u_eye_mv;
		float distanceCamSquared = distanceVector.x*distanceVector.x + distanceVector.y*distanceVector.y + distanceVector.z*distanceVector.z;
		if (distanceCamSquared > fogStartSquared)
		{
			if (distanceCamSquared > fogEndSquared)
			{
				v_fogFactor = 0.0;
			}
			else
			{
				v_fogFactor = (distanceCamSquared - fogStartSquared) / (fogEndSquared - fogStartSquared);
				v_fogFactor = 1.0 - clamp(v_fogFactor, 0.0, 1.0);
			}
		}
		else
		{		
			v_fogFactor = 1.0;
		}
	}
	else
	{
		v_fogFactor = 10.0;
	}
}
#endif