shader_type canvas_item;

uniform sampler2D noise_texture: repeat_enable;
uniform vec4 color;

void fragment() {
	vec2 uv = vec2(UV.x+TIME*0.2, UV.y+TIME*0.2);
	vec2 uv2 = vec2(UV.x-TIME*0.2, UV.y+TIME*0.2);
	vec4 noise_color = texture(noise_texture, uv)+texture(noise_texture, uv2);
	COLOR.rgb = mix(noise_color.rgb, texture(TEXTURE, UV).rgb, 0.7);
	COLOR.rgb = mix(COLOR, color, 0.5).rgb;
	//COLOR = texture(noise_texture, uv).rgba;

}
