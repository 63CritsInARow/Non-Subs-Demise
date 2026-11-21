shader_type canvas_item;

uniform sampler2D SCREEN_TEX : hint_screen_texture, filter_linear_mipmap;

vec3 lighten(vec3 base, vec3 blend){
	return max(base, blend);
}
void fragment() {
	vec3 base = texture(SCREEN_TEX, SCREEN_UV).rgb;
	vec3 blend = COLOR.rgb;
	COLOR.rgb = lighten(base, blend);
}
