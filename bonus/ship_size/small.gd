extends Bonus

func set_sprite():
	$Bonus/Sprite2D.set_texture(load("res://art/time_bonus.png"))

func effect():
	_player.scale = Vector2(0.5, 0.5)
