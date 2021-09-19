extends Node2D

signal all_checks

var num_checks = 0

func _on_Matcher_correct_match():
	num_checks += 1
	get_child(num_checks - 1).visible = true
	if num_checks == 3:
		emit_signal("all_checks")
