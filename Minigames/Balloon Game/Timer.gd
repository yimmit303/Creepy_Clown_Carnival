extends Node2D

signal time_out

var counting = false
var time_left = 20

func _process(delta):
	if counting:
		self.time_left -= delta
		if time_left <= 0:
			$TimeLeft.text = "0.0"
			emit_signal("time_out")
			return
		$TimeLeft.text = str(time_left).left(4)
		
