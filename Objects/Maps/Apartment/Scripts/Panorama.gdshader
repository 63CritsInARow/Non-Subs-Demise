//Ported from Direct3D to GDShader by Bixqa
shader_type canvas_item;

uniform sampler2D SCREEN_TEX : hint_screen_texture, filter_linear_mipmap;

uniform float hr: hint_range(0.0, 1.0) = 0.5;
uniform float vr: hint_range(0.0, 1.0) = 1.0;
uniform float hfov: hint_range(0.0, 360.0) = 180.0;
uniform float vfov: hint_range(0.0, 360.0) = 60;
uniform float z = 1.0;
uniform float ho: hint_range(0.0, 1.0) = 0.5;
uniform float vo: hint_range(0.0, 1.0) = 0.5;
uniform float to = 1.0;
uniform float to2 = 1.0;

void fragment()
{
    vec2 texCoord = SCREEN_UV;
    vec2 newCoord;

    texCoord = (texCoord - 0.5) * z + 0.5;

    vec2 o;
    o.x = radians(hfov);
    o.y = radians(vfov);

    float aspect = 0.5625;

    vec2 fov;
    fov.y = o.y * vr;
    fov.x = atan(1.0 / (aspect / tan(fov.y * 0.5))) * 2.0;

    vec3 v;

    v.x = texCoord.x - 0.5 - (ho - 0.5);
    v.y = (texCoord.y - 0.5) * aspect - to2 * (vo - 0.5);
    v.z = 0.5 / tan(fov.x * 0.5);

    float ta = (0.5 - vo) * (1.0 - vr) * o.y * 2.0;

    float c = cos(ta);
    float s = sin(ta);

    float tz = v.z * c - v.y * s;
    float ty = v.z * s + v.y * c;

    v.z = tz;
    v.y = ty;

    v = normalize(v);

    float lon = atan(v.x, v.z);

    float vz2 = v.x * sin(lon) + v.z * cos(lon);

    float lat = atan(v.y, vz2);

    newCoord.x = lon / (o.x * hr) + 0.5;
    newCoord.y = lat / (o.y * vr) + to * tan((1.0 - vr) * (vo - 0.5)) + 0.5;

    if (any(lessThan(newCoord, vec2(0.0))) ||
        any(greaterThan(newCoord, vec2(1.0))))
    {
        COLOR = vec4(0.0);
    }
    else
    {
        COLOR = texture(SCREEN_TEX, newCoord);
    }
}