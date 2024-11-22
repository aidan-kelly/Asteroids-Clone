extends Control


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_help_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/help_menu.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
