extends Node
@onready var basic_map: Node2D = $BasicMap


func _ready() -> void:
	GameState.state=GameState.PLAYING
	GameState.game_initialized.emit()#ui相关
	'''
	show_item($Flag)
	show_item($NumCaculator/Platform)
	show_item($NumCaculator/Equals)
	show_item($NumCaculator/Label)
	show_item($NumCaculator/NumContainers)
	pass
	'''

func reset_game() -> void:
	var _current_scene = get_tree().current_scene
	var path = _current_scene.scene_file_path
	get_tree().change_scene_to_file(path)


func _on_button_pressed() -> void:
	reset_game()


func _on_next_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(basic_map, "position:y", 
		basic_map.position.y + 500,  # 向下移动500像素
		0.5  # 快速移动，持续0.5秒
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)

	hide_item($NumCaculator/Platform)
	hide_item($NumCaculator/Equals)
	hide_item($NumCaculator/NumContainers)
	hide_item($NumCaculator/Label)
	hide_item($Flag)
	await get_tree().create_timer(1.0).timeout
	
	change_to_next_scene()

func hide_item(node: Node, duration: float = 0.8):
	var tween = create_tween()
	tween.tween_property(node, "modulate:a",
		0.0,  # 目标透明度：完全透明
		duration
	).set_ease(Tween.EASE_IN_OUT)

func show_item(node: Node, duration: float = 0.8):
	node.modulate.a = 0
	var tween = create_tween()
	tween.tween_property(node, "modulate:a",
		1.0,  # 目标透明度：完全透明
		duration
	).set_ease(Tween.EASE_IN_OUT)

# 切换下一个场景的函数
func change_to_next_scene():
	# 方法1：直接切换场景文件
	var transition_scene = preload("res://scenes/animation/transition_scene.tscn").instantiate()
	transition_scene.target_scene = "res://scenes/levels/level_1.tscn"
	get_tree().root.add_child(transition_scene)
