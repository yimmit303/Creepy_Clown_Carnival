extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var platform
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	platform = $Platform
	player = get_node("../../Player")
	
	platform.connect("altarSignal", platform ,"_on_Player_altarSignal")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func interacted():
	#print("pentagram interacted")
	if(platform.ready and not platform.mesh.visible):
		platform.mesh.visible = true
		get_parent().increaseCount()
		#print("now visible")


func _on_Player_interactWithObject(object):
	#print("interact with altar")
	#print(object.name)
	if(object == self):
		interacted()
	


func _on_Player_altarSignal():
	pass # Replace with function body.
