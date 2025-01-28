shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform sampler2D turbulance : repeat_enable;
uniform sampler2D gradient;
uniform vec4 flame_color : source_color;

void fragment() {
	vec4 color = mix(texture(noise, vec2(UV.x, UV.y + TIME*0.2)), texture(gradient, UV), 0.7); 
	color = mix(color, texture(turbulance, vec2(UV.x+TIME*0.1, UV.y+TIME*0.1)), 0.2);
	vec4 flame = vec4(step(0.5, color.rgb) * flame_color.rgb, flame_color.a);
	COLOR = flame;
	if (flame.r == 0.0) {
		COLOR.rgb = texture(TEXTURE, UV).rgb;
	}
	if (texture(TEXTURE, UV).a == 0.0) {
		COLOR.a = 0.0;
	}
	
	
}
