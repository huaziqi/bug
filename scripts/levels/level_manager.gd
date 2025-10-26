extends Node
class_name LevelManager

const TRANSITION_SCENE = preload("uid://3guswm2uo0xu")
@onready var basic_ground: Node2D = $BasicGround
@export var player : Node
@export var next_scene : PackedScene
@export var static_items : Array[Node] #不移动的item，也就是开局要显现出来的
@export var flag : Node
@export var timeline_name : String
var current_dialogue : Node = null
var in_change : bool = false
var first_talk_end : bool = false

func _ready() -> void:
	init_talking()
	init_player()
	init_signal()
	init_ui()
	show_all_items()
	init_position()

func init_position():
	pass

func init_talking():
	var num = Dialogic.VAR.get_variable("interact_time")
	if(num >= 0):
		first_talk_end = true
		return
	get_tree().create_timer(0.8).timeout.connect(func():
		npc_talking()
		)


func init_player():
	if(player):
		player.position = Vector2(100, -10)
	else:
		push_error("player is null")

func npc_talking():
	if(current_dialogue != null or timeline_name == null or timeline_name == ""):
		return
	if(player and "freeze" in player):
		player.freeze = true
	current_dialogue = Dialogic.start(timeline_name)
	get_tree().root.add_child(current_dialogue)
	Dialogic.timeline_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended():
	first_talk_end = true
	if(player):
		player.freeze = false
	if current_dialogue:
		current_dialogue.queue_free()
		current_dialogue = null

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
	if basic_ground:
		tween.tween_property(basic_ground, "position:y", 
			basic_ground.position.y + 500,  # 向下移动500像素
			0.5  # 快速移动，持续0.5秒
		).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		await get_tree().create_timer(1.0).timeout
	change_to_next_scene()

# 切换下一个场景的函数
func change_to_next_scene():
	in_change = true
	Dialogic.end_timeline(true)
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
