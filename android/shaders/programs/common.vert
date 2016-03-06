attribute vec4 a_position;
attribute vec2 a_texCoord;
uniform mat4 u_texCoordMod;
uniform int u_useTexCoordMod;
varying vec2 v_texCoord;
void main()
{
    gl_Position = CC_MVPMatrix*a_position;
    if( u_useTexCoordMod > 0 )
	{
        v_texCoord = (u_texCoordMod*vec4(a_texCoord, 1.0, 1.0)).xy;
    }
	else
	{
        v_texCoord = a_texCoord;
    }
}