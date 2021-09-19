extends AnimatedSprite

var original_path = -1
var face_code = ""

func _ready():
	original_path = get_parent().name[-1]
	
func set_face_code(code):
	var index = 0
	for child in $Face.get_children():
		child.frame = int(code[index])
		index += 1
	face_code = code

func set_face_visible(boolean):
	$Face.visible = boolean
