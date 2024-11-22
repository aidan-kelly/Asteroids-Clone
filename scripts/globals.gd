extends Node

signal stat_change

var score_amount: int = 0:
	set(value):
		if value != score_amount:
			score_amount = value
			stat_change.emit()

var lives_amount: int = 3:
	set(value):
		if value != lives_amount:
			lives_amount = value
			if lives_amount == 0:
				get_tree().change_scene_to_file("res://scenes/game_over_menu.tscn")
			stat_change.emit()

var high_score_amount: int = 0:
	set(value):
		high_score_amount = value
