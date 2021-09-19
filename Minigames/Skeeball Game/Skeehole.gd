extends Area2D
var detection = null
export var score = 0

signal score_hit(val)

func _ready():
	pass # Replace with function body.


func _on_Skeehole_body_entered(body):
	var vel = body.get_vel()
	if vel.y > 0:
		body.queue_free()
		emit_signal("score_hit", score)
