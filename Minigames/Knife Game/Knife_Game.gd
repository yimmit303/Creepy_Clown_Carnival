extends Node2D

var total = 0
var life = 5
var scoreboard = null

func _ready():
	scoreboard = get_child(2)

func scored(score):
	if score < 0:
		life -= 1
	else:
		total += 1
		
func make_inactive():
	get_child(1).disable()
	
func _process(delta):
	scoreboard.print_text("Lives: " + str(life) + "\n" + "Score: " + str(total))
	if total >= 5:
		_on_game_won()
	if life <= 0:
		_on_game_lost()
	
func _on_game_won():
	make_inactive()
	$WinScreen.play()
	yield($WinScreen, "done_playing")

func _on_game_lost():
	make_inactive()
	$LoseScreen.play()
	yield($LoseScreen, "done_playing")
