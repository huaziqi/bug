#需要父节点
extends AnimatedSprite2D 
@export var max_distance: float = 100.0  # 手活动半径
@export var fixed_dist_to_mouse: float = 20.0  # 调整鼠标与手间距
@export var target_rigidbody: RigidBody2D = null  # 要吸附的目标
var is_holding = false

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var parent_pos = get_parent().global_position
	var parent_to_mouse_vec = mouse_pos - parent_pos
	var parent_to_mouse_dist = parent_to_mouse_vec.length()
	var target_pos: Vector2
	grab()
	if parent_to_mouse_dist <= fixed_dist_to_mouse:
		target_pos = parent_pos
	elif (parent_to_mouse_dist - fixed_dist_to_mouse) <= max_distance:
		var dir_from_mouse_to_parent = (parent_pos - mouse_pos).normalized()
		target_pos = mouse_pos + dir_from_mouse_to_parent * fixed_dist_to_mouse
	else:
		var dir_from_parent_to_mouse = parent_to_mouse_vec.normalized()
		target_pos = parent_pos + dir_from_parent_to_mouse * max_distance

	global_position =target_pos
	global_rotation = (get_global_mouse_position() - global_position).angle()

func grab():
	var is_left_mouse_down = Input.is_action_pressed("left_click")
	if is_left_mouse_down:
		play("fist")
		is_holding = true
		if target_rigidbody!=null:
			target_rigidbody.set_process(false)
			target_rigidbody.global_position =target_rigidbody.global_position.move_toward(global_position,10)
	else:
		play("hand")
		if target_rigidbody!=null:
			target_rigidbody.set_process(true)
		is_holding = false

#单个抓取目标
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		target_rigidbody=body
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body==target_rigidbody:
		target_rigidbody=null
