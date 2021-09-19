extends StaticBody2D

signal pass_on(value)

func _on_Skeehole_score_hit(val):
	emit_signal("pass_on", val)
