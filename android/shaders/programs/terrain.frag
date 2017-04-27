// varying
varying vec2 v_texCoordMain;
varying vec2 v_texCoordDetail;
varying float v_distanceToEyeSquared;
// uniform
uniform sampler2D u_texture;
uniform sampler2D u_detail;
uniform vec4 u_weapon_range; // x - Weapon1MaxRange, y - Weapon1MinRange, z - Weapon2MaxRange, w - Weapon2MinRange

#ifndef COMPILE_WITHOUT_FOG
uniform vec3 u_fog_color;
varying float v_fogFactor;
varying float v_fogFactorDiscard;
#endif

#ifndef COMPILE_WITH_MAX_OPTIMIZATION
varying float v_DistanceCameraSquared;
varying float v_DistanceToEyeZSquared;
#endif

#ifdef COMPILE_WITH_WINTER
uniform sampler2D u_snow;
#endif

void main()
{
	gl_FragColor = texture2D(u_texture, v_texCoordMain);
    
#ifdef COMPILE_WITH_WINTER
    vec4 snowFactor = texture2D(u_snow,v_texCoordMain);
    gl_FragColor.rgb =  mix(gl_FragColor.rgb, snowFactor.rgb, snowFactor.a);
#endif
        
    gl_FragColor += (texture2D(u_detail, v_texCoordDetail) - 0.5);
   
#ifndef COMPILE_WITH_MAX_OPTIMIZATION 
    if( v_DistanceCameraSquared < 20000.0*20000.0 )
    {
        gl_FragColor += (texture2D(u_detail, v_texCoordDetail*3.0) - 0.5);
        gl_FragColor += (texture2D(u_detail, v_texCoordDetail*10.0) - 0.5);
    }
    else
    {
	    gl_FragColor += (texture2D(u_detail, v_texCoordDetail*0.5) - 0.5);
    }
#endif

    // x - Weapon1MaxRange
    if(v_distanceToEyeSquared <= u_weapon_range.x)
    {
        // y - Weapon1MinRange
        if(v_distanceToEyeSquared <= u_weapon_range.y)
        {
		    gl_FragColor.rgb = mix(gl_FragColor.rgb, vec3(0.321, 0.015, 0.725), 0.15);
        }
        else
        {
			float factorWeapon = (v_distanceToEyeSquared/u_weapon_range.x - 0.7)*3.3;
			if(factorWeapon > 0.0)
			{
#ifndef COMPILE_WITH_MAX_OPTIMIZATION 
				if(v_DistanceToEyeZSquared > 30.0)
				{
					factorWeapon *= 30.0/v_DistanceToEyeZSquared;
				}
				else if(v_DistanceToEyeZSquared < -200.0)
				{
					factorWeapon *= 200.0/(-v_DistanceToEyeZSquared);
				}
#endif
				gl_FragColor.rgb = mix(gl_FragColor.rgb, vec3(0.486, 0.0, 0.364), 0.255 * factorWeapon);
			}
        }
    }    
    
    // z - Weapon2MaxRange
    if(v_distanceToEyeSquared <= u_weapon_range.z)
    {   
        // w - Weapon2MinRange
        if(v_distanceToEyeSquared <= u_weapon_range.w)
        {
		    gl_FragColor.rgb = mix(gl_FragColor.rgb, vec3(0.321, 0.015, 0.725), 0.15);
        }
        else
        {
			float factorWeapon = (v_distanceToEyeSquared/u_weapon_range.z - 0.7)*3.3;
			if(factorWeapon > 0.0)
			{
#ifndef COMPILE_WITH_MAX_OPTIMIZATION 
				if(v_DistanceToEyeZSquared > 30.0)
				{
					factorWeapon *= 30.0/v_DistanceToEyeZSquared;
				}
				else if(v_DistanceToEyeZSquared < -200.0)
				{
					factorWeapon *= 200.0/(-v_DistanceToEyeZSquared);
				}
#endif
				gl_FragColor.rgb = mix(gl_FragColor.rgb, vec3(0.486, 0.0, 0.364), 0.255 * factorWeapon);
			}
        }
    }
    
#ifndef COMPILE_WITHOUT_FOG
	if( v_fogFactor < 1.0 )
	{
		gl_FragColor.rgb = (gl_FragColor * v_fogFactor + vec4(u_fog_color * (1.0 - v_fogFactor), 1.0)).rgb;

		if(v_fogFactorDiscard > 0.65)
		{
			discard;
		}
	}

#endif
}