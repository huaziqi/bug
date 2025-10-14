#需要父节点
extends Area2D
@export var max_distance: float = 150.0  # 手活动半径
@export var fixed_dist_to_mouse: float = 20.0  # 调整鼠标与手间距
@export var target_rigidbodies: Array = [] # 要吸附的目标,暂时使用collisionshape的信号获取目标
var is_holding = false

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	var parent_pos = get_parent().global_position
	check_target_freed(target_rigidbodies)
	grab()
	follow(mouse_pos,parent_pos)

func follow(mouse_pos,parent_pos):
	var parent_to_mouse_vec = mouse_pos - parent_pos
	var parent_to_mouse_dist = parent_to_mouse_vec.length()
	var target_pos: Vector2
	if parent_to_mouse_dist <= fixed_dist_to_mouse:
		target_pos = parent_pos
	elif (parent_to_mouse_dist - fixed_dist_to_mouse) <= max_distance:
		var dir_from_mouse_to_parent = (parent_pos - mouse_pos).normalized()
		target_pos = mouse_pos + dir_from_mouse_to_parent * fixed_dist_to_mouse
	else:
		var dir_from_parent_to_mouse = parent_to_mouse_vec.normalized()
		target_pos = parent_pos + dir_from_parent_to_mouse * max_distance
	global_position=target_pos	
	global_rotation = (get_global_mouse_position() - global_position).angle()
	#让大拇指朝上
	$AnimatedSprite2D.flip_v=rad_to_deg(global_rotation)<90 and rad_to_deg(global_rotation)>-90	

func grab():
	var is_left_mouse_down = Input.is_action_pressed("left_click") #根据项目设置修改
	if is_left_mouse_down:
		$AnimatedSprite2D.play("fist")
		is_holding = true
		if target_rigidbodies!=[]:
			target_rigidbodies[-1].gravity_scale=0
			target_rigidbodies[-1].global_position =target_rigidbodies[-1].global_position.move_toward(global_position,10)
			
			#if target_rigidbodies[-1].is_in_group("weapons"):
				#if rad_to_deg(global_rotation)<=90 and rad_to_deg(global_rotation)>=-90:
					#target_rigidbodies[-1].global_rotation=global_rotation
				#else	:
					#target_rigidbodies[-1].global_rotation=deg_to_rad(rad_to_deg(global_rotation)+180)
			#
	else:
		$AnimatedSprite2D.play("hand")
		if target_rigidbodies!=[]:
			for body in target_rigidbodies:
				
				body.gravity_scale=body.b_gravity
		is_holding = false

#删除已经释放的目标
func check_target_freed(array):
	for body in array:
		if not is_instance_valid(body):
			array.erase(body)
#单个抓取目标			
func _on_body_entered(body: Node2D) -> void:
#筛选抓取目标，石山需要优化
	if (body.is_in_group("enemies") or body.is_in_group("weapons") or body.is_in_group("player"))and not is_holding:
		target_rigidbodies.append(body)
func _on_body_exited(body: Node2D) -> void:
	if not is_holding:
		target_rigidbodies.erase(body)
