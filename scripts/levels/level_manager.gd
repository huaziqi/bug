extends Node


func reset_game() -> void:
	var current_scene = get_tree().current_scene
	var path = current_scene.scene_file_path
	get_tree().change_scene_to_file(path)


func _on_button_pressed() -> void:
	reset_game()
