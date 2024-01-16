extends CollisionShape3D
#------------------------------------------------------------------------------#
#Put In Globals If Used
var image: Image = load(ProjectSettings.get_setting("shader_globals/heightmap").value).get_image()
var amplitude: float = ProjectSettings.get_setting("shader_globals/amplitude").value
var size = image.get_width()

#Shader Heightmap
func get_height(x, z):
	@warning_ignore("narrowing_conversion")
	return image.get_pixel(fposmod(x, size), fposmod(z, size)).r * amplitude
#Put In Globals If Used
#------------------------------------------------------------------------------#
@export var template_mesh: PlaneMesh
@onready var faces = template_mesh.get_faces()
@onready var snap = Vector3.ONE * template_mesh.size.x / 2
@onready var player = G.PLAYER

func _ready():
	update_shape()

func _physics_process(_delta):
	var pRound_POS = player.global_position.snapped(snap) * Vector3(1, 0, 1)
	if !global_position == pRound_POS:
		global_position = pRound_POS
		update_shape()

func update_shape():
	for f in faces.size():
		var global_vert = faces[f] + global_position
		faces[f].y = G.get_height(global_vert.x, global_vert.z)
	self.shape.set_faces(faces)
	rotation.y = 0
