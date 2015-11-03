
// attribute
attribute vec4 a_position;
attribute vec2 a_texCoord;
// uniform
uniform mat4 u_texCoordMod;
uniform int u_useTexCoordMod;
// varying
varying vec2 v_texCoord;
// declarations
void UpdateFogFactor();

// main vertex
void main()
{
    gl_Position = CC_MVPMatrix * a_position;
	if( u_useTexCoordMod > 0 )
	{
		v_texCoord = (u_texCoordMod*vec4(a_texCoord, 1.0, 1.0)).xy;
	}
	else
	{
		v_texCoord = a_texCoord;
	}
#ifndef SETTINGS_DISABLE_FOG
	UpdateFogFactor();
#endif
}
