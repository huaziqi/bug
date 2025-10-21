extends Node
class_name LevelManager
@onready var basic_map : Node2D = $BasicMap

@export var static_items : Array[Node] #不移动的item

func _ready() -> void:
	GameState.state=GameState.PLAYING
	GameState.game_initialized.emit()#ui相关
	show_all_items()

func show_all_items(): #展示所有的物品
	for item in static_items:
		if(is_instance_valid(item)):
			show_item(item)

func _on_button_pressed() -> void:
	reset_game()

func _on_next_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(basic_map, "position:y", 
		basic_map.position.y + 500,  # 向下移动500像素
		0.5  # 快速移动，持续0.5秒
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	await get_tree().create_timer(1.0).timeout
	change_to_next_scene()

func reset_game() -> void:
	var _current_scene = get_tree().current_scene
	var path = _current_scene.scene_file_path
	get_tree().change_scene_to_file(path)

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
	var transition_scene = preload("res://scenes/animation/transition_scene.tscn").instantiate()
	transition_scene.target_scene = "res://scenes/levels/level_1.tscn"
	get_tree().root.add_child(transition_scene)
