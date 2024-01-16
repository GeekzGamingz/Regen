@tool
#Inherits StaticBody3D Code
extends StaticBody3D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export_category("World Generation")
@export var generate_mesh = false: set = generate
@export var size = 64
@export var subdivision = 63
@export var amplitude = 16
@export var noise = FastNoiseLite.new()
#------------------------------------------------------------------------------#
#Generate World Mesh
func generate(_mesh):
	#Generates/Divides Mesh
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(size, size)
	plane_mesh.subdivide_depth = subdivision
	plane_mesh.subdivide_width = subdivision
	#Surface Tool
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(plane_mesh, 0)
	var data = surface_tool.commit_to_arrays()
	var vertices = data[ArrayMesh.ARRAY_VERTEX]
	#Vertex Noise Manipulation
	for v in vertices.size():
		var vertex = vertices[v]
		vertices[v].y = noise.get_noise_2d(vertex.x, vertex.z) * amplitude
	data[ArrayMesh.ARRAY_VERTEX] = vertices #Writes Data
	var array_mesh = ArrayMesh.new() #Creates Mesh
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, data)
	#Normals Generation
	surface_tool.create_from(array_mesh, 0)
	surface_tool.generate_normals()
	#Commit Changes
	$MeshInstance3D.mesh = surface_tool.commit() #Overwrites Mesh
	$CollisionShape3D.shape = array_mesh.create_trimesh_shape() #Generates Collision
