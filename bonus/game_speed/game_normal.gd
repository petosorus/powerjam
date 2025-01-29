extends Bonus

signal game_speed

func effect():
	var main = get_parent().get_parent()
	main.update_game_speed(1)
