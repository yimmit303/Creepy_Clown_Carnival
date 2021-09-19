extends Sprite

signal fished_pumpkin(pumpkin)

var can_hook = false
var hooking = false
var reeling = false
var has_pumpkin = false
var top_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	self.top_pos = self.position.y
	pass # Replace with function body.

func _process(delta):
	if hooking:
		self.position.y += 300 * delta
	if reeling:
		self.position.y -= 700 * delta
		if self.position.y <= top_pos:
			reeling = false
			if has_pumpkin:
				emit_signal("fished_pumpkin", get_child(2))
				has_pumpkin = false

func _input(event):
	if can_hook:
		if event is InputEventMouseButton and event.pressed == true and event.button_index == BUTTON_LEFT:
			if not hooking and not reeling:
				hooking = true

func _on_HookArea_area_entered(area):
	if area.get_parent().is_in_group("PUMPKIN") and hooking == true and has_pumpkin == false:
		var pumpkin = area.get_parent()
		hooking = false
		reeling = true
		has_pumpkin = true
		pumpkin.frame = 1
		pumpkin.set_face_visible(true)
		pumpkin.get_parent().call_deferred("remove_child", pumpkin)
		pumpkin.get_node("Area/Shape").call_deferred("set", "disabled", true)
		self.call_deferred("add_child", pumpkin)
	else:
		hooking = false
		reeling = true

func _on_Matcher_matching_started():
	can_hook = false

func _on_Matcher_matching_done():
	can_hook = true
