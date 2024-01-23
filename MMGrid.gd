@tool
extends Node3D
 
@onready var pos: Vector3 #this will the center point of the grid 
@onready var grid_size #how many LoDs you want from the center
@onready var chunksize #side size of the instance cluster patch/chunk
@onready var grid_created = false #used to ensure the grid creator only runs once as opposed to on every update
 
 
func create_grid(pos, grid_size:int, chunksize: int):
	print("create grid")
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
	
		
func position_grid(grid_points,grid_size,chunksize):    
	for i in grid_points:
		i = Vector3(i.x - (grid_size/2 * chunksize), i.y, i.z + (grid_size/2 * chunksize))
		#load chunks
		var multi_mesh_instance = MultiMeshInstance3D.new()
		add_child(multi_mesh_instance) #adding the mm instances as children of the Instancer node
		multi_mesh_instance.global_position = i
		#set the parameters of this chunk
		#it's best to save the instancer script with its export variables as a Resource first
		#and then load it here and pass in the desired parameters
 
func _update():
	#this is your update function
	pass