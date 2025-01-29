shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_width = 4.0;

void fragment() {
	vec4 final_color = COLOR;
	vec2 pixel_size = TEXTURE_PIXEL_SIZE;
	float right_alpha = texture(TEXTURE, vec2(UV.x+TEXTURE_PIXEL_SIZE.x*outline_width, UV.y)).a;
	if(right_alpha >= 0.9){
		final_color.rgba = outline_color;
	}
	float left_alpha = texture(TEXTURE, vec2(UV.x-TEXTURE_PIXEL_SIZE.x*outline_width, UV.y)).a;
	if(left_alpha >= 0.9){
		final_color.rgba = outline_color;
	}
	float top_alpha = texture(TEXTURE, vec2(UV.x, UV.y+TEXTURE_PIXEL_SIZE.y*outline_width)).a;
	if(top_alpha >= 0.9){
		final_color.rgba = outline_color;
	}
	float bottom_alpha = texture(TEXTURE, vec2(UV.x, UV.y-TEXTURE_PIXEL_SIZE.y*outline_width)).a;
	if(bottom_alpha >= 0.9){
		final_color.rgba = outline_color;
	}


	float top_right_aplha = texture(TEXTURE, vec2(UV.x+TEXTURE_PIXEL_SIZE.x*outline_width, UV.y+TEXTURE_PIXEL_SIZE.y*outline_width)).a;
	if(top_right_aplha >= 0.9){
		final_color.rgba = outline_color;
	}
	float top_left_alpha = texture(TEXTURE, vec2(UV.x-TEXTURE_PIXEL_SIZE.x*outline_width, UV.y+TEXTURE_PIXEL_SIZE.y*outline_width)).a;
	if(top_left_alpha >= 0.9){
		final_color.rgba = outline_color;
	}
	float bottom_right_alpha = texture(TEXTURE, vec2(UV.x+TEXTURE_PIXEL_SIZE.x*outline_width, UV.y-TEXTURE_PIXEL_SIZE.y*outline_width)).a;
	if(bottom_right_alpha >= 0.9){
		final_color.rgba = outline_color;
	}
	float bottom_left_alpha = texture(TEXTURE, vec2(UV.x-TEXTURE_PIXEL_SIZE.x*outline_width, UV.y-TEXTURE_PIXEL_SIZE.y*outline_width)).a;
	if(bottom_left_alpha >= 0.9){
		final_color.rgba = outline_color;
	}

	if (COLOR.a >= 0.9){
		final_color.rgb = texture(TEXTURE, UV).rgb;
	}

	COLOR = final_color;
}
