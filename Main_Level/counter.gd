extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func increaseCount():
	count += 1
	
	if(count >= 5):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

		get_tree().change_scene("Credits/Credits.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
