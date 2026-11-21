shader_type canvas_item;

instance uniform float X = 0.5;
instance uniform float Y = 0.5;
instance uniform float I = 5.0;

void fragment() {
	float dist = distance(UV, vec2(X, Y));
	COLOR.rgba = vec4(0.0, 0.0, 0.0, dist * I);
}
