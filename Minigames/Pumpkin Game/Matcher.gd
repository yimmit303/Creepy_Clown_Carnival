extends Node2D

signal return_pumpkins(pumps)
signal correct_match
signal matching_done
signal matching_started

var pump1 = null
var pump2 = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _get_pumpkin(pumpkin):
	pumpkin.get_parent().remove_child(pumpkin)
	self.add_child(pumpkin)
	if pump1 == null:
		pump1 = pumpkin
		pumpkin.position = $Selector.position
	elif pump2 == null:
		pump2 = pumpkin
		pumpkin.position = $Selector2.position
	
	if pump1 != null and pump2 != null:
		compare_pumpkins()

func compare_pumpkins():
	emit_signal("matching_started")
	yield(get_tree().create_timer(1.0), "timeout")
	if pump1.face_code == pump2.face_code:
		pump1.queue_free()
		pump2.queue_free()
		pump1 = null
		pump2 = null
		emit_signal("correct_match")
	else:
		emit_signal("return_pumpkins", [pump1, pump2])
		pump1 = null
		pump2 = null
	emit_signal("matching_done")
