shader_type canvas_item;

uniform float windAmount = 0.5;
uniform float amplitude = 2.0;

void vertex() {
    // bottom anchored, top max wobble
	float y01 = clamp(UV.y + 0.3, 0.0, 1.0);
    float y_offset = 1.0 - y01;
	y_offset = y_offset * y_offset;
	
	float wave = sin(TIME * windAmount);
	VERTEX.x += wave * amplitude * y_offset;
}
