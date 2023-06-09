shader_type canvas_item;
render_mode unshaded;

uniform float hue_shift_amount : hint_range(-1, 1);
uniform float sat_shift_amount : hint_range(-1, 1);
uniform float val_shift_amount : hint_range(-1, 1);

vec3 rgb2hsb(vec3 c){
	vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = mix(vec4(c.bg, K.wz),
				vec4(c.gb, K.xy),
				step(c.b, c.g));
	vec4 q = mix(vec4(p.xyw, c.r),
				vec4(c.r, p.yzx),
				step(p.x, c.r));
	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)),
				d / (q.x + e),
				q.x);
}

vec3 hsb2rgb(vec3 c){
	vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
					6.0)-3.0)-1.0,
					0.0,
					1.0 );
	rgb = rgb*rgb*(3.0-2.0*rgb);
	return c.z * mix(vec3(1.0), rgb, c.y);
}

void fragment() {
	// Get color from the sprite texture at the current pixel we are rendering
	vec4 original_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	vec3 col = original_color.rgb;
	vec3 hsb = rgb2hsb(col);
	// If not greyscale
	if(col[0] != col[1] || col[1] != col[2]) {
		// Shift the color by shift_amount, but rolling over the value goes over 1
		hsb.x = mod(hsb.x + hue_shift_amount, 1.0);
	}
	if(sat_shift_amount > 0.0) {
		hsb.y =  mix(hsb.y, 1 , sat_shift_amount);
	}
	else if (sat_shift_amount < 0.0) {
		hsb.y =  mix(0, hsb.y , 1.0 - abs(sat_shift_amount));
	}

	if(val_shift_amount > 0.0) {
		hsb.z =  mix(hsb.z, 1 , val_shift_amount);
	}
	else if (val_shift_amount < 0.0) {
		hsb.z =  mix(0, hsb.z , 1.0 - abs(val_shift_amount));
	}
	
	col = hsb2rgb(hsb);
	
	if ((UV.x < 0.02 || UV.x > 0.98) || (UV.y < 0.03 || UV.y > 0.9)){
		col.rgb = vec3(0.0);
	}
	
	vec3 output = col;
	COLOR = vec4(output.rgb, original_color.a);
	
	if ((UV.x < 0.02 || UV.x > 0.98) || (UV.y < 0.03 || UV.y > 0.9)){
		COLOR.a = 0.5;
	}
	
}