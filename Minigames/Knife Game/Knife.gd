extends KinematicBody2D

var lifetime = 15.0
var stuck = false
var vel = Vector2.ZERO
const UP = Vector2(0, -1)
const GRAVITY = 1.5
const MAXFALL = 200
const FRICTION = 0.05
var wheel = null

func _ready():
	wheel = self.get_parent().get_parent().get_node("Wheel")

func throw(force, angle):
	var x = cos(angle) * force
	var y = -sin(angle) * force
	self.vel = Vector2(x, y)

func reparent():
	var old = self.get_parent()
	var transformation = get_global_transform()
	old.remove_child(self)
	wheel.add_child(self)
	set_global_transform(transformation)

func hit_wheel():
	wheel.hit()

func _physics_process(delta):
	if not stuck:
		self.vel.x -= FRICTION
		if self.vel.x <= 0:
			self.vel.x = 0
		self.vel.y += GRAVITY
		if self.vel.y > MAXFALL:
			self.vel.y = MAXFALL
		var collide = move_and_collide(self.vel, false)
		if collide:
			stuck = true
			self.vel = Vector2.ZERO
			reparent()
			hit_wheel()
	if stuck:
		lifetime -= delta
		if lifetime <= 0:
			queue_free()

