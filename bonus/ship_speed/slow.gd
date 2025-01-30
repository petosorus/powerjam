extends Bonus

func set_sprite():
	$Bonus/Sprite2D.set_texture(load("res://art/speed_bonus.png"))

func effect():
	_player.speed = _player.default_speed / 2
