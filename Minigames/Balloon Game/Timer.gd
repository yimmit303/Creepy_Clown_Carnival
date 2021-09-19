extends Node2D

signal time_out

var counting = false
var num_digits = 4
export var time_left = 20

func _process(delta):
	if counting:
		self.time_left -= delta
		if time_left > 100:
			num_digits = 5
		elif time_left < 10:
			num_digits = 3
		else:
			num_digits = 4
		if time_left <= 0:
			$TimeLeft.text = "0.0"
			emit_signal("time_out")
			return
		$TimeLeft.text = str(time_left).left(num_digits)
		
