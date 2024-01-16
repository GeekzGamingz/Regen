#@tool
extends MeshInstance3D

var x
var z
#var _mesh
#var generated_mesh

@export_category("World Generation")
#@export var generate_mesh = false: set = generate
#@export var size = 64
#@export var subdivision = 63
#@export var amplitude = 16
#@export var noise = FastNoiseLite.new()

@onready var length = ProjectSettings.get_setting("shader_globals/clipmap_partition_length").value
@onready var lod_step = ProjectSettings.get_setting("shader_globals/lod_step").value
@onready var lod = max(abs(x), abs(z)) * lod_step
@onready var subdivision_length = pow(2, lod)
@onready var subdivides = max(length / subdivision_length - 1, 0)

func _ready():
	#generate(generated_mesh)
	mesh = PlaneMesh.new()
	#generated_mesh.size = Vector2.ONE * length FAIL
	mesh.size = Vector2.ONE * length #SUX
	
	position = Vector3(x, 0, z) * length
	

	mesh.subdivide_width = subdivides
	mesh.subdivide_depth = subdivides

#func generate(_mesh):
	##Generates/Divides Mesh
	#var plane_mesh = PlaneMesh.new()
	#plane_mesh.size = Vector2(size, size) * length #attempt2
	#plane_mesh.subdivide_depth = subdivides
	#plane_mesh.subdivide_width = subdivides
	##Surface Tool
	#var surface_tool = SurfaceTool.new()
	#surface_tool.create_from(plane_mesh, 0)
	#var data = surface_tool.commit_to_arrays()
	#var vertices = data[ArrayMesh.ARRAY_VERTEX]
	##Vertex Noise Manipulation
	#for v in vertices.size():
		#var vertex = vertices[v]
		#vertices[v].y = noise.get_noise_2d(vertex.x, vertex.z) * amplitude
	#data[ArrayMesh.ARRAY_VERTEX] = vertices #Writes Data
	#var array_mesh = ArrayMesh.new() #Creates Mesh
	#array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, data)
	##Normals Generation
	#surface_tool.create_from(array_mesh, 0)
	#surface_tool.generate_normals()
	##Commit Changes
	#mesh = surface_tool.commit() #Overwrites Mesh
	#$CollisionShape3D.shape = array_mesh.create_trimesh_shape() #Generates Collision
