extends Area

var player 
var ready_to_play = false
var currentMachine #is set by arcade machine

var collisionShape

signal interactWith
var mat

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../../Player")
	
	collisionShape = $PlayerHandCollisionShape

	mat = load("Main_Level/Materials/DefaultMat.tres")

	#set_contact_monitor(true)
	#set_max_contacts_reported(5)
	set_monitorable(true)
	set_monitoring(true)
	
	connect("body_entered", self, "enable_outline")
	connect("body_exited", self, "disable_outline")
	connect("area_entered", self, "enable_outline")
	connect("area_exited", self, "disable_outline")
	
func setOutline(body, ammount = 5, enable = true):
	#print("touching: ", body.name)
	#print("parent: ", body.get_parent().name)
	var par = body.get_parent()
	if(par is MeshInstance):
		#print("mesh")
		if(par.is_in_group("Interactable")):
			#print("interact")
			
			var number = par.get_surface_material_count()
			for i in range(0, number):
				var currentMaterial = par.get_active_material(i)
				
				#print(currentMaterial)
				
				var nextPass = currentMaterial.next_pass
				
				#print(nextPass)
				
				if(nextPass == null):
					#nextPass = currentMaterial.duplicate()
					nextPass = mat.duplicate()
					#nextPass.Flags.FLAG_UNSHADED = true
					#nextPass.set_flag(true)
					nextPass.flags_unshaded = true
					nextPass.set_cull_mode(1) #CullMode.CULL_FRONT
					#nextPass.params_cull_mode = CULL_FRONT
					nextPass.set_grow_enabled(true)
					nextPass.set_grow(ammount)
					currentMaterial.set_next_pass(nextPass)
				else:
					nextPass.set_grow(ammount)
			ready_to_play = enable
			if(enable):
				currentMachine = body
			else:
				currentMachine = null
	else:
		#old code
		
		#if(enable):
		#	ammount = 0.05
		
		for i in range(0, body.get_child_count()):
			var child = body.get_child(i)
			if(child is MeshInstance and child.is_in_group("Interactable")):
				#print(child.name)
				
				var number = child.get_surface_material_count()
				
				#print(number)
				for j in range(0, number):
					#rint(j)
					var currentMaterial = child.get_active_material(j)
					print(currentMaterial)
					var nextPass = currentMaterial.next_pass
					if(nextPass == null):
						nextPass = currentMaterial.duplicate()
						#nextPass.Flags.FLAG_UNSHADED = true
						#nextPass.set_flag(true)
						#nextPass.emission.enabled = true
						
						nextPass.flags_unshaded = true
						nextPass.set_cull_mode(1) #CullMode.CULL_FRONT
						#nextPass.params_cull_mode = CULL_FRONT
						nextPass.set_grow_enabled(true)
						nextPass.set_grow(ammount)
						currentMaterial.set_next_pass(nextPass)
					else:
						nextPass.set_grow(ammount)
		#print("enable that boi")
		
		ready_to_play = enable
		if(enable):
			currentMachine = body
		else:
			currentMachine = null
	
func enable_outline(body):
	#print("touching: ", body.name)
	#print("touching: ", body.get_parent().name)
	setOutline(body)
	
func disable_outline(body):
	setOutline(body, 0, false)
	
func _process(delta):
	if(player.in_minigame):
		return
	if(ready_to_play and player.interact):
		#print("player interacting with obj: ", currentMachine)
		#ready_to_play and currentMachine are set via arcade machine
		if(currentMachine):
			#print("interact with: ", currentMachine.name)
			currentMachine._on_Player_interactWithObject(currentMachine)
			
			#emit_signal("interactWith", currentMachine)
			
			"""
			player.swapCamera(currentMachine)
			player.interact = false
			ready_to_play = false
			"""
