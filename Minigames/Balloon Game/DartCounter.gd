extends Node2D

signal game_lost
var darts_left = 5

func _ready():
	var offset = 0
	for child in self.get_children():
		child.position.x += offset
		offset += 30

func _on_dart_thrown():
	if darts_left > 0:
		var child = self.get_children()[-1]
		child.queue_free()
		darts_left -= 1
	if darts_left == 0:
		emit_signal("game_lost")
