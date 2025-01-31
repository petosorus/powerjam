extends PathFollow2D

signal mob_hit

const _speed = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var newProgress = self.get_progress() + _speed * delta
	var pathLength = get_parent().curve.get_baked_length()
	
	# Garder les mob paths est fun ???
	if (newProgress >= pathLength):
		delete()
	self.set_progress(newProgress)

func delete():
	get_parent().queue_free()
	queue_free()


func _on_mob_area_entered(area: Area2D) -> void:
	if area.name.begins_with("Weapon") or area.name.begins_with("Splitter"):
		mob_hit.emit()
		get_parent().queue_free()
		queue_free()
