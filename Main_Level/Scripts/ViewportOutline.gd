extends Viewport

var rootViewport
var sprite

func _ready():
	#var rootViewport = get_node("/root")
	rootViewport = get_tree().get_root()
	sprite = $PostProcessingSprite
