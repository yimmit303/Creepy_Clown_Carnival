extends Node2D

var total = 0
var life = 5


func scored(score):
	if score < 0:
		life -= 1
		_on_game_lost()
	else:
		total += 1
		_on_game_won()
		
func make_inactive():
	$Knife_Spawner.disable()
	
func _process(delta):
	$Scoreboard.print_text("Lives: " + str(life) + "\n" + "Score: " + str(total))
	
func _on_game_won():
	if total >= 5:
		make_inactive()
		$WinScreen.play()
		yield($WinScreen, "done_playing")

func _on_game_lost():
	if life <= 0:
		make_inactive()
		$LoseScreen.play()
		yield($LoseScreen, "done_playing")
