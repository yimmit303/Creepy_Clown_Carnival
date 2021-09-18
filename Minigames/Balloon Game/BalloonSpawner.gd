extends Node2D

var Balloon = load("Minigames/Balloon Game/Balloon.tscn")

var num_clowns = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(5):
		for y in range(3):
			var new_balloon = Balloon.instance()
			new_balloon.position = Vector2(600 + 175 * x + (y % 2 * 100), 350 + 200 * y)
			new_balloon.scale = Vector2(0.75, 0.75)
			new_balloon.self_modulate = Color().from_hsv(randf(), 1, 1)
			if num_clowns > 0:
				new_balloon.is_clown = true
				num_clowns -= 1
				new_balloon.show_clown()
			self.add_child(new_balloon)

func pop_all():
	for child in get_children():
		if not child is AudioStreamPlayer:
			child.pop()

func _on_balloon_popped():
	$Pop.play()
	for child in get_children():
		if not child is AudioStreamPlayer:
			child.speed += 200


func _on_bad_balloon_popped():
	$Pop.play()
