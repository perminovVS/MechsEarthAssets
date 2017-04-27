
// attribute
attribute vec4 a_position;
attribute vec2 a_texCoord;
// varying
varying vec2 v_texCoord;
// main vertex
void main()
{
    gl_Position = CC_MVPMatrix * a_position;
    v_texCoord = a_texCoord;
}