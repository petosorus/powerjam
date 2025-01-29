extends PathFollow2D

class_name Bonus

var _player
const _speed = 100

func set_player(player):
	_player = player

func effect():
	print("no effect on base class")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var newProgress = self.get_progress() + _speed * delta
	var pathLength = get_parent().curve.get_baked_length()
	if (newProgress >= pathLength):
		delete()
	self.set_progress(newProgress)
	

func delete():
	get_parent().queue_free()
	queue_free()

func _on_bonus_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		effect()
		queue_free()
