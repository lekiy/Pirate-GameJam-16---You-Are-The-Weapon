shader_type canvas_item;

uniform sampler2D gradient;
uniform sampler2D screen_texture : hint_screen_texture;
uniform float transition_amount = 0.5;

void fragment() {
	vec4 circle = smoothstep(transition_amount-0.1, transition_amount+0.1, texture(gradient, UV));
	COLOR = vec4(1.0 - texture(screen_texture, SCREEN_UV) + circle);
	//COLOR = texture(screen_texture, SCREEN_UV).rgba;
}
