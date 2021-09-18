extends Node2D

var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func make_active():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func pause_game():
	pass
