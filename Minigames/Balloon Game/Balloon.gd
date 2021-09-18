extends AnimatedSprite

var speed = 300
var direction = Vector2(0, 0)
var is_clown = false
var time = 0

func _ready():
	self.direction = Vector2(randf() - 0.5, randf() - 0.5)
	self.direction = self.direction.normalized()

func _process(delta):
	self.position += direction * speed * delta

func _on_Area2D_area_entered(area):
	if area.name == "BorderTop":
		self.direction.y *= -1
	if area.name == "BorderSide":
		self.direction.x *= -1

func pop():
	self.play()

func _on_Balloon_animation_finished():
	self.queue_free()

func show_clown():
	$Clown.modulate.a = 1
