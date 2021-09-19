extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var leftSide
var rightSide

var aliveObjects = []

var coinPrefab
var evilHandPrefab
var rng = RandomNumberGenerator.new()
var my_random_number

export var coinSpawnChance = 0.85

signal spanwedCoin

# Called when the node enters the scene tree for the first time.
func _ready():
	leftSide = $SpawnLocation_Left
	rightSide = $SpawnLocation_Right
	
	coinPrefab = load("res://Minigames/Coin Game/Prefabs/Coin.tscn")
	evilHandPrefab = load("res://Minigames/Coin Game/Prefabs/Evilhand2.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DustBunny_Spawnable_spawnCoin(rigidBody):
	
	my_random_number = rng.randf_range(0, 100)
	if(my_random_number >= coinSpawnChance):
		var newCoin = coinPrefab.instance()
		newCoin.set_name("coin")
		add_child(newCoin)
		
		newCoin.position = rigidBody.get_global_position()
		rng.randomize()
		my_random_number = rng.randf_range(-5000, 5000)
		newCoin = newCoin.get_child(0)
		newCoin.velocity.x = my_random_number
		my_random_number = rng.randf_range(-5000, 5000)
		newCoin.velocity.y = my_random_number
		
		aliveObjects.append(newCoin)
		
		emit_signal("spanwedCoin", newCoin)
		
func _on_Evilhand2_deadHand():
	#spawn 2 more evil hands!
	
	for j in range(0, 2):
		var newHand = evilHandPrefab.instance()
		newHand.set_name("heilHydra")
		add_child(newHand)
		
		rng.randomize()
		#153,21 -> 1733, 787
		var x = rng.randf_range(153, 1733)
		var y = rng.randf_range(21, 787)
		newHand.kinematicBody.position.x = x
		newHand.kinematicBody.position.y = y
		
		for i in range(0, aliveObjects.size()):
			var child = aliveObjects[i]
			if(child.is_in_group("Coin")):
				newHand._on_ItemSpawner_spanwedCoin(child)
				break
		
		aliveObjects.append(newHand)
	
