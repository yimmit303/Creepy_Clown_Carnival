extends Spatial

var maxSize = 3.5
var minSize = 0.2

var emissionStrengthMax = 100
var emissionStrengthMin = 1

var sprites = []
var time = 0
var rng

var contactArea

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	for i in range(0, get_child_count()):
		var child = get_child(i)
		if(child.get_class() == "Sprite3D"):
			sprites.append(child)
			print(child.name)
			var newScale = (maxSize-minSize) * (rng.randi() % 1 + 0.1)
			child.scale = Vector3(newScale,newScale,newScale)
	
	contactArea = $CoinGameArea
	contactArea.set_monitorable(true)
	contactArea.set_monitoring(true)
	
	contactArea.player = get_node("../Player")


func _process(delta):
	for i in range(0, sprites.size()):
		var star = sprites[i]
		
		var newScale = (sin(time) - minSize) 
		star.scale = Vector3(newScale,newScale,newScale)
		
		time += delta
