shader_type canvas_item;

uniform vec2 anchor1 = vec2(0.0);
uniform vec2 anchor2 = vec2(0.0);
uniform vec2 anchor3 = vec2(0.0);
uniform vec2 anchor4 = vec2(0.0);
uniform vec2 anchor5 = vec2(0.0);
uniform vec2 anchor6 = vec2(0.0);

uniform vec2 move1 = vec2(0.0);
uniform vec2 move2 = vec2(0.0);
uniform vec2 move3 = vec2(0.0);
uniform vec2 move4 = vec2(0.0);
uniform vec2 move5 = vec2(0.0);
uniform vec2 move6 = vec2(0.0);

uniform float range1 = 0.0;
uniform float range2 = 0.0;
uniform float range3 = 0.0;
uniform float range4 = 0.0;
uniform float range5 = 0.0;
uniform float range6 = 0.0;

uniform float power = 1.0;


vec3 rgb2hsl(vec3 c )
{
    float epsilon = 0.00000001;
    float cmin = min( c.r, min( c.g, c.b ) );
    float cmax = max( c.r, max( c.g, c.b ) );
    float cd   = cmax - cmin;
    vec3 hsl = vec3(0.0);
    hsl.z = (cmax + cmin) / 2.0;
    hsl.y = mix(cd / (cmax + cmin + epsilon), cd / (epsilon + 2.0 - (cmax + cmin)), step(0.5, hsl.z));

    vec3 a = vec3(1.0 - step(epsilon, abs(cmax - c)));
    a = mix(vec3(a.x, 0.0, a.z), a, step(0.5, 2.0 - a.x - a.y));
    a = mix(vec3(a.x, a.y, 0.0), a, step(0.5, 2.0 - a.x - a.z));
    a = mix(vec3(a.x, a.y, 0.0), a, step(0.5, 2.0 - a.y - a.z));
    
    hsl.x = dot( vec3(0.0, 2.0, 4.0) + ((c.gbr - c.brg) / (epsilon + cd)), a );
    hsl.x = (hsl.x + (1.0 - step(0.0, hsl.x) ) * 6.0 ) / 6.0;
	hsl.y = clamp (hsl.y, 0.0, 1.0);
    return hsl;
}

vec3 hsl2rgb(vec3 HSL)
{
  float R = abs(HSL.x * 6.0 - 3.0) - 1.0;
  float G = 2.0 - abs(HSL.x * 6.0 - 2.0);
  float B = 2.0 - abs(HSL.x * 6.0 - 4.0);
  vec3 RGB = clamp(vec3(R,G,B), 0.0, 1.0);
  float C = (1.0 - abs(2.0 * HSL.z - 1.0)) * HSL.y;
  return (RGB - 0.5) * C + HSL.z;
}

uniform vec4 target1color : hint_color;
uniform vec4 target2color : hint_color;
uniform vec4 target3color : hint_color;

uniform vec4 part1color : hint_color;
uniform vec4 part2color : hint_color;
uniform vec4 part3color : hint_color;

uniform float range = 0.7;
uniform float lmod = 0.6;

uniform float midpoint = 0.5;
uniform float steepness = 2.0;

void fragment(){
    vec4 color = texture(TEXTURE, UV);
	float a = color.a;
	vec3 t1 = rgb2hsl(target1color.rgb);
	vec3 t2 = rgb2hsl(target2color.rgb);
	vec3 t3 = rgb2hsl(target3color.rgb);
	vec3 k = rgb2hsl(color.rgb);
	k = pow (k, vec3(1.0, 1.0, lmod));
	if (abs(k.x - t1.x) < range){
		vec3 dcolor = rgb2hsl(part1color.rgb);
		float rot = dcolor.x - t1.x;
		k.x = k.x + rot;
		k.y = dcolor.y;
		if (k.z > midpoint){
			k.z = ((steepness - 1.0) * k.z / midpoint + (2.0 - steepness)) * k.z;
		} else {
			k.z = ((steepness - 1.0) * k.z * k.z  + (2.0 * midpoint - midpoint * steepness - steepness) * k.z + midpoint * (steepness - 1.0)) / (midpoint - 1.0);
		}
		k.z *= dcolor.z;
		k = hsl2rgb(k);
		color = vec4(k.xyz, a);
		}
	else if (abs(k.x - t2.x) < range){
		vec3 dcolor = rgb2hsl(part2color.rgb);
		float rot = dcolor.x - t2.x;
		k.x = k.x + rot;
		k.y = dcolor.y;
		if (k.z > midpoint){
			k.z = ((steepness - 1.0) * k.z / midpoint + (2.0 - steepness)) * k.z;
		} else {
			k.z = ((steepness - 1.0) * k.z * k.z  + (2.0 * midpoint - midpoint * steepness - steepness) * k.z + midpoint * (steepness - 1.0)) / (midpoint - 1.0);
		}
		k.z *= dcolor.z;
		k = hsl2rgb(k);
		color = vec4(k.xyz, a);
		}
	else if (abs(k.x - t3.x) < range){
		vec3 dcolor = rgb2hsl(part3color.rgb);
		float rot = dcolor.x - t3.x;
		k.x = k.x + rot;
		k.y = dcolor.y;
		if (k.z > midpoint){
			k.z = ((steepness - 1.0) * k.z / midpoint + (2.0 - steepness)) * k.z;
		} else {
			k.z = ((steepness - 1.0) * k.z * k.z  + (2.0 * midpoint - midpoint * steepness - steepness) * k.z + midpoint * (steepness - 1.0)) / (midpoint - 1.0);
		}
		k.z *= dcolor.z;
		k = hsl2rgb(k);
		color = vec4(k.xyz, a);
		}
	COLOR = color;
}


void vertex(){
	vec2 offset = vec2(0.0);
	float dist = length(VERTEX - anchor1);
	
	if (dist < range1){
		offset += move1 * (range1 - dist) * power / range1;
	}
	dist = length(VERTEX - anchor2);
	if (dist < range2){
		offset += move2 * (range2 - dist) * power / range2;
	}
	dist = length(VERTEX - anchor3);
	if (dist < range3){
		offset += move3 * (range3 - dist) * power / range3;
	}
	dist = length(VERTEX - anchor4);
	if (dist < range4){
		offset += move4 * (range4 - dist) * power / range4;
	}
	dist = length(VERTEX - anchor5);
	if (dist < range5){
		offset += move5 * (range5 - dist) * power / range5;
	}
	dist = length(VERTEX - anchor6);
	if (dist < range6){
		offset += move6 * (range6 - dist) * power / range6;
	}
	VERTEX += offset;
}