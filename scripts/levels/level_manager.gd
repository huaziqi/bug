extends Node
class_name LevelManager

const TRANSITION_SCENE = preload("uid://3guswm2uo0xu")
@onready var basic_ground: Node2D = $BasicGround
@export var player : Node
@export var next_scene : PackedScene
@export var static_items : Array[Node] #不移动的item，也就是开局要显现出来的
@export var flag : Node

func _ready() -> void:
	init_player()
	init_signal()
	init_ui()
	show_all_items()



func init_player():
	if(player):
		player.position = Vector2(50, -10)
	else:
		push_error("player is null")

func init_signal():
	if(flag):
		flag.flag_up.connect(quit_current_level)
	else:
		push_error("flag is null")

func init_ui() -> void:
	GameState.state=GameState.PLAYING
	GameState.game_initialized.emit() #ui相关

func show_all_items(): #展示所有的物品
	for item in static_items:
		if(is_instance_valid(item)):
			show_item(item)

func _on_button_pressed() -> void:
	reset_game()

func quit_current_level() -> void:
	var tween = create_tween()
	tween.tween_property(basic_ground, "position:y", 
		basic_ground.position.y + 500,  # 向下移动500像素
		0.5  # 快速移动，持续0.5秒
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	await get_tree().create_timer(1.0).timeout
	change_to_next_scene()

# 切换下一个场景的函数
func change_to_next_scene():
	if(not next_scene):
		return
	TransitionInfo.next_scene = next_scene
	get_tree().change_scene_to_packed(TRANSITION_SCENE)

func reset_game() -> void:
	var _current_scene = get_tree().current_scene
	var path = _current_scene.scene_file_path
	get_tree().change_scene_to_file(path)

func hide_item(node: Node, duration: float = 0.8):
	var tween = create_tween()
	tween.tween_property(node, "modulate:a",
		0.0,  
		duration
	).set_ease(Tween.EASE_IN_OUT)

func show_item(node: Node, duration: float = 0.8):
	node.modulate.a = 0
	var tween = create_tween()
	tween.tween_property(node, "modulate:a",
		1.0,  
		duration
	).set_ease(Tween.EASE_IN_OUT)
