extends Bonus

func set_sprite():
	$Bonus/Sprite2D.set_texture(load("res://art/time_bonus.png"))

func effect():
	var main = get_parent().get_parent()
	main.update_game_speed(2)
