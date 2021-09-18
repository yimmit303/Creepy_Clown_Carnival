extends Node2D
var knife = load("Minigames/Knife Game/Knife.tscn")
var set_spawn = false
var max_delay = 2.0
var delay = 0.0
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				if delay <= 0.0:
					delay = 0.0
					set_spawn = true


func _process(delta):
	if set_spawn:
		delay = max_delay
		set_spawn = false
		var new_knife = knife.instance()
		new_knife.position = position
		self.add_child(new_knife)
	else:
		delay -= delta
