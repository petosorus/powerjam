extends Bonus

func effect():
	var main = get_parent().get_parent()
	main.update_game_speed(1)
