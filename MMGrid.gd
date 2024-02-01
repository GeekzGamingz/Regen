@tool
extends Node3D
const INSTANCER = preload("res://source/World/ProcGen/Grass/Grass_Instance.tscn")
var multi_mesh_instance
var dict = {}
var last_position
@export var player_node: Node3D

@onready var pos: Vector3 #this will the center point of the grid 
@onready var grid_size #how many LoDs you want from the center
@onready var chunksize #side size of the instance cluster patch/chunk
@onready var grid_created = false #used to ensure the grid creator only runs once as opposed to on every update
@onready var length = ProjectSettings.get_setting("shader_globals/clipmap_partition_length").value
@onready var grid_instancer = $"."


func _ready():
	create_grid(pos, 3, 15)

func create_grid(pos, grid_size:int, chunksize: int):
	print("Creating Grid...")
	var t = pos
	var width = 0
	var height = 0
	var grid_points = []
	for i in range (grid_size):
		for x_point in range(grid_size):
			var x = Vector3(t.x + width,t.y,t.z)
			grid_points.append(x)
			width += chunksize
		width = 0
		t.z -= chunksize
		t.x -= width
		
		if i == grid_size-1:
			position_grid(grid_points,grid_size,chunksize)
			if !grid_created:_update()
			grid_created = true
			print("Grid Created!")
	
		
func position_grid(grid_points,grid_size,chunksize):    
	var ticks = 0

	for i in grid_points:
		i = Vector3(i.x - (grid_size/2 * chunksize), i.y, i.z + (grid_size/2 * chunksize))
		#load chunks
		#var multi_mesh_instance = MultiMeshInstance3D.new()
		ticks += 1
		multi_mesh_instance = INSTANCER.instantiate()
		dict[str("instance" + str(ticks))] = multi_mesh_instance
		
		add_child(dict[str("instance" + str(ticks))]) #adding the mm instances as children of the Instancer node
		multi_mesh_instance.global_position = i

		#set the parameters of this chunk
		#it's best to save the instancer script with its export variables as a Resource first
		#and then load it here and pass in the desired parameters

 
func _update():
	if player_node != null:
		global_position = player_node.global_position.snapped(Vector3.ONE * length) * Vector3(1, 0, 1)
		if global_position != last_position:
			for instancer in get_children():
				instancer.global_position.x = global_position.x - instancer.global_position.x
				instancer.global_position.z = global_position.z - instancer.global_position.z
		last_position = global_position
				
		#for instance in dict:
			#dict[instance].global_position = player_node.global_position.snapped(Vector3.ONE * length) * Vector3(1, 0, 1)
		#print("Updated.")
