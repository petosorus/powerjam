extends Node

@export var bonus_scene: PackedScene
var score
var bonuses = [
	"res://bonus/big.gd",
	"res://bonus/normal.gd",
	"res://bonus/small.gd"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start($StartPosition.position)
	$BonusTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	pass
	#$ScoreTimer.stop()
	#$MobTimer.stop()
	#
	#$HUD.show_game_over()

func new_game():
	score = 0
	#$Player.start($StartPosition.position)
	#$StartTimer.start()
	#
	#$HUD.update_score(score)
	#$HUD.show_message("Get ready")
	#
	#get_tree().call_group("mobs", "queue_free")


func _on_bonus_timer_timeout() -> void:
	var bonus = bonus_scene.instantiate()
	bonus.set_script(load(bonuses.pick_random()))
	bonus.set_player($Player)
	$BonusPath.add_child(bonus)
	
