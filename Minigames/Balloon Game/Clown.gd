extends Sprite

var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	if randf() > 0.5:
		direction = -1
	pass # Replace with function body.

func _process(delta):
	self.rotation_degrees += 200 * delta * direction
