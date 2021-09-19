extends Node2D

var face_codes = ["0110", "0000", "1111", "1001", "0000", "1111", "0110", "1001"]

# Called when the node enters the scene tree for the first time.
func _ready():
	var offset = 0
	for path in $PumpkinPath.get_children():
		path.unit_offset = (1.0/$PumpkinPath.get_child_count()) * offset
		offset += 1
	var index = 0
	for pumpkin in get_pumpkins():
		pumpkin.animation = "Float" + str(randi() % 3 + 1)
		pumpkin.set_face_code(face_codes[index])
		index += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for path in $PumpkinPath.get_children():
		path.offset += 150 * delta

func get_pumpkins():
	return get_tree().get_nodes_in_group("PUMPKIN")


func _on_return_pumpkins(pumps):
	for pump in pumps:
		pump.get_parent().call_deferred("remove_child", pump)
		pump.get_node("Area/Shape").call_deferred("set", "disabled", false)
		var origin = pump.original_path
		for path in $PumpkinPath.get_children():
			var path_num = path.name[-1]
			if origin == path_num:
				path.call_deferred("add_child", pump)
				pump.position = Vector2(0, 0)
				pump.frame = 0
				pump.set_face_visible(false)
				break
