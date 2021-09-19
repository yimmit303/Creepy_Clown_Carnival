extends KinematicBody2D
const GRAVITY = 0.4
var vel = Vector2.ZERO
var timer = 30

func _ready():
	pass # Replace with function body.
	
func get_vel():
	return vel

func _process(delta):
	timer -= delta
	if timer < 0:
		queue_free()

func shoot(force):
	vel = Vector2(0, -force)

func _physics_process(delta):
	vel.y += GRAVITY
	var collide = move_and_collide(vel)
	if collide:
		vel = vel.bounce(collide.normal)
