extends Node2D

signal done_playing

func play():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,0,0,1), 2.0, Tween.TRANS_QUAD, Tween.EASE_IN)
	$Tween.interpolate_property(self, "scale", Vector2(0,1), Vector2(1,1), 2.0, Tween.TRANS_QUAD, Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	emit_signal("done_playing")

func reset():
	self.modulate.a = 0
