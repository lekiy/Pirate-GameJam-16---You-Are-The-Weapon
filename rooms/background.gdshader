shader_type canvas_item;

uniform sampler2D noise_texture : repeat_enable;
uniform sampler2D noise_texture_2 : repeat_enable;
uniform sampler2D screen : hint_screen_texture;

void fragment() {
	vec4 a = mix(texture(noise_texture, SCREEN_UV-TIME*0.02), texture(noise_texture, SCREEN_UV+TIME*0.02), 0.5);
	vec4 b = mix(a, texture(noise_texture_2, SCREEN_UV+TIME*0.001), 0.5);
	vec4 c = vec4(0.4, 0.1, 0.4, step(a.r, 0.5));
	COLOR = mix(mix(step(0.5, mix(mix(c, step(0.5, b), 0.5), c, 0.5)), a, 0.5), vec4(0.0), 0.3);
	//COLOR = mix(texture(screen, SCREEN_UV), d, 0.5);
}
