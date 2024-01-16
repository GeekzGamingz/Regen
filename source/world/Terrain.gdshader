shader_type spatial;
// Adds Shader Parameters
uniform sampler2D grass_texture: source_color;
uniform sampler2D rock_texture: source_color;
uniform sampler2D sand_texture: source_color;
// Uniform Floats
uniform float min_rock_slope: hint_range(0.0, 1.0, 0.01) = 0.5;
uniform float max_grass_slope: hint_range(0.0, 1.0, 0.01) = 0.9;
uniform float min_rockgrass_height: hint_range(-10.0, 1.0, 0.01) = -8.0;
uniform float max_sand_height: hint_range(-10.0, 1.0, 0.01) = -6.0;
// Varying Float
varying float normal_y;
varying float vertex_y;
// Vertex
void vertex() {
	// Called for every vertex the material is visible on.
	normal_y = NORMAL.y;
	vertex_y = VERTEX.y;
}
// Fragment
void fragment() {
	// Called for every pixel the material is visible on.
	// Albedo Values
	vec3 grass_albedo = texture(grass_texture, UV * 4.0).xyz;
	vec3 rock_albedo = texture(rock_texture, UV * 4.0).xyz;
	vec3 sand_albedo = texture(sand_texture, UV * 4.0).xyz;
	// Weights
	float rock_grass_weight = normal_y;
	float sand_rockgrass_weight = vertex_y;
	// Calculating Rock/Grass Weight
	rock_grass_weight = max(min_rock_slope, rock_grass_weight);
	rock_grass_weight = min(max_grass_slope, rock_grass_weight);
	rock_grass_weight -= min_rock_slope;
	rock_grass_weight /= max_grass_slope - min_rock_slope;
	// Calculating Sand/Rock/Grass Weight
	sand_rockgrass_weight = max(min_rockgrass_height, sand_rockgrass_weight);
	sand_rockgrass_weight = min(max_sand_height, sand_rockgrass_weight);
	sand_rockgrass_weight -= min_rockgrass_height;
	sand_rockgrass_weight /= max_sand_height - min_rockgrass_height;
	// Mix Shades
	vec3 rockgrass_albedo = mix(rock_albedo, grass_albedo, rock_grass_weight);
	ALBEDO = mix(sand_albedo, rockgrass_albedo, sand_rockgrass_weight);
}
// Light
//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
