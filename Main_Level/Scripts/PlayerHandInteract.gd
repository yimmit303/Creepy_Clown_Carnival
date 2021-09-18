extends Area

var player 
var ready_to_play = false
var currentMachine #is set by arcade machine

var collisionShape

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../../Player")
	
	collisionShape = $PlayerHandCollisionShape

	#set_contact_monitor(true)
	#set_max_contacts_reported(5)
	set_monitorable(true)
	set_monitoring(true)
	
	connect("body_entered", self, "enable_outline")
	connect("body_exited", self, "disable_outline")
	connect("area_entered", self, "enable_outline")
	connect("area_exited", self, "disable_outline")
	
func enable_outline(body):
	#print(body.name)
	for i in range(0, body.get_child_count()):
		var child = body.get_child(i)
		if(child is MeshInstance):
			#print(child.name)
			var currentMaterial = child.get_active_material(0)
			var nextPass = currentMaterial.next_pass
			if(nextPass == null):
				nextPass = currentMaterial.duplicate()
				#nextPass.Flags.FLAG_UNSHADED = true
				#nextPass.set_flag(true)
				nextPass.flags_unshaded = true
				nextPass.set_cull_mode(1) #CullMode.CULL_FRONT
				#nextPass.params_cull_mode = CULL_FRONT
				nextPass.set_grow_enabled(true)
				nextPass.set_grow(0.05)
				currentMaterial.set_next_pass(nextPass)
			else:
				nextPass.set_grow(0.05)
	#print("enable that boi")
	
	ready_to_play = true
	currentMachine = body

func disable_outline(body):
	#print(body.name)
	for i in range(0, body.get_child_count()):
		var child = body.get_child(i)
		if(child is MeshInstance):
			#print(child.name)
			var currentMaterial = child.get_active_material(0)
			var nextPass = currentMaterial.next_pass
			if(nextPass == null):
				nextPass = currentMaterial.duplicate()
				#nextPass.Flags.FLAG_UNSHADED = true
				nextPass.set_flag(true)
				nextPass.set_cull_mode(1) #CullMode.CULL_FRONT
				#nextPass.params_cull_mode = CULL_FRONT
				nextPass.set_grow_enabled(true)
				nextPass.set_grow(0.00)
				currentMaterial.set_next_pass(nextPass)
			else:
				nextPass.set_grow(0.00)
	#print("disable that boi")
	ready_to_play = false
	currentMachine = null
	
func _process(delta):
	if(player.in_minigame):
		return
	if(ready_to_play and player.interact):
		#print("start game!")
		
		#ready_to_play and currentMachine are set via arcade machine
		if(currentMachine):
			player.swapCamera(currentMachine)
			
			player.interact = false
			ready_to_play = false
