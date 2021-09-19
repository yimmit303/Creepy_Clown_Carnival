extends Button

func _ready():
	get_node("../../Music").play()

func _on_Start_pressed():
	get_tree().change_scene("Main_Level/Root.tscn")
