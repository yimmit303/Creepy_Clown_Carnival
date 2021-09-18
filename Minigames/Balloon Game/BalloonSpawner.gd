extends Node2D

var Balloon = load("Minigames/Balloon Game/Balloon.tscn")

var balloon_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(5):
		for y in range(3):
			var new_balloon = Balloon.instance()
			new_balloon.position = Vector2(600 + 175 * x + (y % 2 * 100), 350 + 200 * y)
			new_balloon.scale = Vector2(6, 6)
			self.add_child(new_balloon)
	var children = self.get_children()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
