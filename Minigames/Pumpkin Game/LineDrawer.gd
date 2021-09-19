extends Node2D

var start_point = Vector2(0,0)
var end_point = Vector2(0,0)

func _draw():
	draw_line(start_point, end_point, Color.black, 4.0, true)

func update_variables(start, end):
	start_point = start
	end_point = end
	update()
