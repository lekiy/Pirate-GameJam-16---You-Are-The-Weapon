shader_type canvas_item;

uniform sampler2D shine : repeat_enable;
uniform vec4 color : source_color;

void fragment() {
	
	float color_average = (COLOR.r + COLOR.g + COLOR.b);
	COLOR.rgb = vec3(color_average);
	COLOR.rgb = COLOR.rgb * color.rgb; 
	COLOR.rgb = COLOR.rgb + texture(shine, UV*0.1 - TIME*0.3).rgb;
}

