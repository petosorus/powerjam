extends Bonus

func set_sprite():
	$Bonus/Sprite2D.set_texture(load("res://art/orientation_bonus.png"))

func effect():
	_player.scale = Vector2(1, 1)
