#Inherits Node3D Code
extends Node
#------------------------------------------------------------------------------#
#Constants
#------------------------------------------------------------------------------#
#Variables
var image: Image = load(ProjectSettings.get_setting("shader_globals/heightmap").value).get_image()
var image_size = image.get_width()
var amplitude: float = ProjectSettings.get_setting("shader_globals/amplitude").value
#OnReady Variables
@onready var PLAYER = get_tree().get_root().get_node("WorldRoot/Kinematics/Player")
@onready var UI = get_tree().get_root().get_node("WorldRoot/UIRoot")
#------------------------------------------------------------------------------#
#Globals Functions
func get_height(x, z):
	@warning_ignore("narrowing_conversion")
	return image.get_pixel(fposmod(x, image_size), fposmod(z, image_size)).r * amplitude
