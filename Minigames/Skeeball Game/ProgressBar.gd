extends ProgressBar

signal shoot(value)

var charge = false
var total = 0

func _process(delta):
	if charge:
		total += 100 * delta
		if total >= 100:
			total = 100
	if not charge:
		total = 0
	self.percent_visible = total


func _on_Skeeball_Spawner_charging():
	print_debug("AAAAAAAAAA")
	charge = true


func _on_Skeeball_Spawner_not_charging():
	charge = false
	print_debug(total)
	emit_signal("shoot", total)
	total = 0
