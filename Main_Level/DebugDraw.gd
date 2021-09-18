extends ImmediateGeometry

var start = null
var end = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setPoints(_start, _end):
	start = _start
	end = _end
	
func _process(delta):
	if(start != null and end != null):
		self.clear()
		self.begin(PrimitiveMesh.PRIMITIVE_LINES)
		self.set_color(Color(1,1,1))
		self.add_vertex(start) 
		self.add_vertex(end)	
		self.end()
