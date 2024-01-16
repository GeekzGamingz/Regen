#Inherits Node3D Code
extends Node
#------------------------------------------------------------------------------#
#Constants
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var PLAYER = get_tree().get_root().get_node("WorldRoot/Kinematics/Player")
@onready var UI = get_tree().get_root().get_node("WorldRoot/UIRoot")
