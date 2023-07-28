// Thanks to https://godotshaders.com/shader/line-art/
shader_type canvas_item;
uniform float strength = 0.01;
uniform vec4 color : hint_color;


void fragment(){
	vec3 current_color = texture(TEXTURE, UV).rgb;
	vec3 right_color = texture(TEXTURE, UV + vec2(TEXTURE_PIXEL_SIZE.x, 0)).rgb;
	vec3 bottom_color = texture(TEXTURE, UV - vec2(0, TEXTURE_PIXEL_SIZE.y)).rgb;
	float r_distance = length(current_color - right_color);
	float b_distance = length(current_color - bottom_color);

	COLOR.rgba = (r_distance > strength || b_distance > strength) ? color : vec4(0);
}