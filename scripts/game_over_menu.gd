extends Control

func _ready() -> void:
	$MarginContainer/VBoxContainer/ScoreLabel.text = str(Globals.score_amount) + " points"
	if Globals.score_amount > Globals.high_score_amount:
		Globals.high_score_amount = Globals.score_amount
	$MarginContainer/VBoxContainer/HighScoreLabel.text = "High Score: " + str(Globals.high_score_amount)

func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
