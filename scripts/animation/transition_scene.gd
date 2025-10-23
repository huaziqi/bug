extends Node2D
@onready var camera_2d: Camera2D = $Camera2D

@export var transition_speed: float = 50.0  # 摄像头上移速度
var next_scene : PackedScene

# 内部变量
var is_transitioning: bool = false
var next_scene_instance: Node = null

func _ready():
	next_scene = TransitionInfo.next_scene
	start_transition()
	$Camera2D/startscenes/AudioStreamPlayer2D.play()
func start_transition():
	if not next_scene:
		return
	if is_transitioning:
		return
	
	is_transitioning = true

	print(next_scene.resource_path)
	# 异步加载下一个场景
	ResourceLoader.load_threaded_request(next_scene.resource_path)
	
	# 开始摄像头上移动画
	start_camera_movement()

func start_camera_movement():
	# 创建补间动画让摄像头上移
	var tween = create_tween()
	var original_x = camera_2d.position.x
	tween.tween_property(camera_2d, "position:y", 
		camera_2d.position.y + 255,
		1.0
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	# 动画结束后检查场景加载状态
	tween.finished.connect(_on_camera_movement_finished)
	
	tween.finished.connect(_on_camera_movement_finished)
func _on_camera_movement_finished():

	var progress = []
	var status = ResourceLoader.load_threaded_get_status(next_scene.resource_path, progress)
	
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		_finish_transition()
	else:
		await get_tree().process_frame
		_on_camera_movement_finished()

func _finish_transition():
	var scene_path = next_scene.resource_path
	var loaded_scene_resource = ResourceLoader.load_threaded_get(scene_path)
	
	if not loaded_scene_resource:
		push_error("无法获取加载的场景资源: " + scene_path)
		is_transitioning = false
		return
	
	if not loaded_scene_resource is PackedScene:
		push_error("加载的资源不是场景: " + scene_path)
		is_transitioning = false
		return

	get_tree().change_scene_to_packed(loaded_scene_resource)
	
	is_transitioning = false
