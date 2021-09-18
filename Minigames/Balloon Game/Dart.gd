extends Node2D

signal dart_thrown
signal balloon_popped
signal bad_balloon_popped

var difficulty_scale = 1
var offset = Vector2(0, 0)
var time = 0
var balloons_in_sight = []
var can_throw = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if can_throw:
		$Reticle.position = get_viewport().get_mouse_position() + offset
		offset.y = 25 * difficulty_scale * sin(4 * difficulty_scale * time)
		offset.x = 25 * difficulty_scale * sin(2 * difficulty_scale * time + PI)
		time += delta

func _input(event):
	if can_throw and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed == true:
		if len(balloons_in_sight) > 0:
			if balloons_in_sight[0].is_clown != true:
				emit_signal("balloon_popped")
			else:
				emit_signal("bad_balloon_popped")
			balloons_in_sight[0].pop()
			balloons_in_sight.remove(0)
			$Tween.interpolate_property(self, "difficulty_scale", difficulty_scale, difficulty_scale + 1, 0.5, Tween.TRANS_LINEAR)
			$Tween.start()
		emit_signal("dart_thrown")
		$DartSound.play(2.3)

func _on_DartArea_area_entered(area):
	if area.get_parent().is_in_group("BALLOON"):
		balloons_in_sight.append(area.get_parent())

func _on_DartArea_area_exited(area):
	if area.get_parent().is_in_group("BALLOON"):
		if balloons_in_sight.has(area.get_parent()):
			balloons_in_sight.remove(balloons_in_sight.find(area.get_parent()))
