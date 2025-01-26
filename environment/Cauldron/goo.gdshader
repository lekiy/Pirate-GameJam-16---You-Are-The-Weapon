shader_type canvas_item;

uniform sampler2D noise : repeat_enable;

void fragment() {
	vec4 noise_col = texture(noise, UV + TIME*0.5);
	COLOR = texture(TEXTURE, UV +  0.05 * noise_col.r);
}

