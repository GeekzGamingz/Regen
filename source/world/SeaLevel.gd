extends MeshInstance3D

func _physics_process(delta):
	position.x = G.PLAYER.position.x
	position.z = G.PLAYER.position.z
	rotation.y = G.PLAYER.rotation.y
