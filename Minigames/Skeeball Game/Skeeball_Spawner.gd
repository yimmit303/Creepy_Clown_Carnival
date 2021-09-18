extends Node2D
var skeeball = load("Minigames/Skeeball Game/Skeeball.tscn")
var set_spawn = false
var max_delay = 2.0
var delay = 0.0
var force = 0
var max_force = 30

signal charging()
signal not_charging()

func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			if delay <= 0.0:
				delay = 0.0
				emit_signal("charging")
		else:
			if delay <= 0.0:
				emit_signal("not_charging")
				delay = 0.0
				set_spawn = true


func _process(delta):
	position.x = get_viewport().get_mouse_position().x
	if not set_spawn:
		delay -= delta


func _on_ProgressBar_shoot(value):
	force = (value / 100) * max_force
	delay = max_delay
	set_spawn = false
	var transformation = get_global_transform()
	var new_ball = skeeball.instance()
	new_ball.shoot(force)
	new_ball.set_global_transform(transformation)
	self.get_parent().add_child(new_ball)
