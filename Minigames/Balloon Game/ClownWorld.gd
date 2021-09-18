extends Node2D

func _on_DartThrower_bad_balloon_popped():
	$Laugh.play()
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 5.8, Tween.TRANS_LINEAR)
	$Tween.start()
