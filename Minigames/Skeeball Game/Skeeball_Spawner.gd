extends Node2D
var skeeball = load("Minigames/Skeeball Game/Skeeball.tscn")
var force = 0
var max_force = 30
var disabled = true

signal charging()
signal not_charging()

func reset():
	force = 0
	max_force = 30
	disabled = true
	emit_signal("not_charging")

func activate():
	disabled = false

func disable():
	disabled = true

func _input(event):
	if not disabled:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if event.pressed:
				emit_signal("charging")
			else:
				emit_signal("not_charging")


func _process(delta):
	if not disabled:
		position.x = get_viewport().get_mouse_position().x


func _on_ProgressBar_shoot(value):
	if get_parent().ammo > 0 and not disabled:
		force = (value / 100) * max_force
		var transformation = get_global_transform()
		var new_ball = skeeball.instance()
		new_ball.shoot(force)
		new_ball.set_global_transform(transformation)
		self.get_parent().add_child(new_ball)
		get_parent().ammo -= 1
