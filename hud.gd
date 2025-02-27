extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game over")
	$MessageTimer.stop()
	
	#$Message.text = "Survive my dude\nGet bonuses"
	#$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$RestartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func hide_menu():
	$StartButton.hide()
	$RestartButton.hide()
	$Message.hide()

# Called when the node enters the scene tree for the first time.
func _ready():
	$RestartButton.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
