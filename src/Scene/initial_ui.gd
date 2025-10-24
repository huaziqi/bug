extends VBoxContainer


func _on_continue_pressed() -> void:
	GameState.continue_ui.emit()


func _on_setting_pressed() -> void:
	GameState.setting_ui.emit()


func _on_select_level_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	GameState.quit_ui.emit()
