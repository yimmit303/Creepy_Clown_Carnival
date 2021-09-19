extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var leftSide
var rightSide

var aliveObjects = []

var coinPrefab
var evilHandPrefab
var dustBunnyPrefab
var rng = RandomNumberGenerator.new()
var my_random_number

export var coinSpawnChance = 0
export var dustSpawnChance = 55

signal spanwedCoin
signal addOneToPlayerCoins

# Called when the node enters the scene tree for the first time.
func _ready():
	leftSide = $SpawnLocation_Left
	rightSide = $SpawnLocation_Right
	
	coinPrefab = load("res://Minigames/Coin Game/Prefabs/Coin.tscn")
	evilHandPrefab = load("res://Minigames/Coin Game/Prefabs/Evilhand2.tscn")
	dustBunnyPrefab = load("res://Minigames/Coin Game/Prefabs/DustBunny.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DustBunny_Spawnable_spawnCoin(rigidBody):
	
	my_random_number = rng.randf_range(0, 100)
	if(my_random_number >= coinSpawnChance):
		var newCoin = coinPrefab.instance()
		newCoin.set_name("coin")
		add_child(newCoin)
		
		newCoin.connect("coinUpForGrabs", self, "_on_Coin_coinUpForGrabs")
		
		newCoin.position = rigidBody.get_global_position()
		rng.randomize()
		my_random_number = rng.randf_range(-5000, 5000)
		newCoin = newCoin.get_child(0)
		newCoin.velocity.x = my_random_number
		my_random_number = rng.randf_range(-5000, 5000)
		newCoin.velocity.y = my_random_number
		
		aliveObjects.append(newCoin)
		
		emit_signal("spanwedCoin", newCoin)
		
func _on_Evilhand2_deadHand(num = 2):
	#spawn 2 more evil hands!
	
	for j in range(0, num):
		var newHand = evilHandPrefab.instance()
		newHand.set_name("heilHydra" + str(j))
		add_child(newHand)
		
		newHand.connect("deadHand", self, "_on_Evilhand2_deadHand")
		
		for i in range(0, aliveObjects.size()):
			var child = aliveObjects[i]
			if(child.is_in_group("Coin")):
				newHand._on_ItemSpawner_spanwedCoin(child)
				break
		
		aliveObjects.append(newHand)
		
		my_random_number = rng.randf_range(0, 100)
		if(my_random_number >= dustSpawnChance):
			var newDust = dustBunnyPrefab.instance()
			newDust.set_name("dust" + str(j))
			add_child(newDust)
			aliveObjects.append(newDust)
		
func _on_Coin_coinUpForGrabs(humanPointYesNo, coin):
	print("count up")
	print(coin)
	
	coin = get_node(coin)
	
	if(humanPointYesNo):
		emit_signal("addOneToPlayerCoins")
	
	print(coin)
	
	for i in range(0, aliveObjects.size()):
		var child = aliveObjects[i]
		if(child.is_in_group("Enemy")):
			if(child.coin == coin):
				child.coin = null
		
	coin.queue_free()
