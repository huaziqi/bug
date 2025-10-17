extends Node2D
@onready var camera_2d: Camera2D = $Camera2D

# 过渡参数
@export var transition_speed: float = 50.0  # 摄像头上移速度
@export var target_scene: String = "res://scenes/levels/level_1.tscn"       # 目标场景路径

# 内部变量
var is_transitioning: bool = false
var next_scene_instance: Node = null

func _ready():
	# 开始过渡
	start_transition_to(target_scene)

func start_transition_to(scene_path: String):
	if scene_path.is_empty():
		push_error("目标场景路径为空!")
		return
	
	if is_transitioning:
		return
	
	is_transitioning = true
	
	# 异步加载下一个场景
	ResourceLoader.load_threaded_request(scene_path)
	
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
	
	tween.parallel().tween_property(camera_2d, "position:x", original_x + 15, 0.2)
	tween.parallel().tween_property(camera_2d, "position:x", original_x - 10, 0.2).set_delay(0.2)
	tween.parallel().tween_property(camera_2d, "position:x", original_x + 5, 0.2).set_delay(0.4)
	tween.parallel().tween_property(camera_2d, "position:x", original_x, 0.2).set_delay(0.6)
	
	tween.finished.connect(_on_camera_movement_finished)
func _on_camera_movement_finished():
	# 检查场景是否加载完成
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(target_scene, progress)
	
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		_finish_transition()
	else:
		# 如果还没加载完，等待一帧再检查
		await get_tree().process_frame
		_on_camera_movement_finished()

func _finish_transition():
	# 提前获取 tree 引用
	var tree = get_tree()
	if not tree:
		push_error("场景树不存在，无法完成过渡")
		return
	
	# 获取加载的场景实例
	next_scene_instance = ResourceLoader.load_threaded_get(target_scene).instantiate()
	
	# 移除当前场景
	var old_scene = tree.current_scene
	if old_scene and old_scene != self:
		tree.root.remove_child(old_scene)
		old_scene.queue_free()
	
	# 添加新场景并设置为当前场景
	tree.root.add_child(next_scene_instance)
	tree.current_scene = next_scene_instance
	
	# 移除过渡场景
	queue_free()
