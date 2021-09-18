extends Node2D
var knife = load("Minigames/Knife Game/Knife.tscn")
var set_spawn = false
var disabled = false
var max_delay = 1.0
var delay = 0.0
func _ready():
	pass # Replace with function body.

func disable():
	disabled = true

func _input(event):
	if not disabled:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT:
				if event.pressed:
					if delay <= 0.0:
						delay = 0.0
						set_spawn = true


func _process(delta):
	if not disabled:
		if set_spawn:
			delay = max_delay
			set_spawn = false
			var new_knife = knife.instance()
			new_knife.throw(48, 45)
			self.add_child(new_knife)
		else:
			delay -= delta
