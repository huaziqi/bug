extends RigidBody2D

# 移动参数
@export var move_force = 800.0
@export var jump_impulse = 500.0  # 改成正数！
@export var torque_strength = 5000.0

# 地面检测
var is_grounded = false
var ground_contacts = 0

func _ready():
	# 不锁定旋转，让棍子可以自由旋转
	lock_rotation = false
	# 连续碰撞检测
	continuous_cd = RigidBody2D.CCD_MODE_CAST_SHAPE
	# 角阻尼
	angular_damp = 1.0
	# 线性阻尼
	linear_damp = 0.1
	
	# 确保使用自定义积分（重要！）
	contact_monitor = true
	max_contacts_reported = 10

func _physics_process(delta):
	# 获取输入方向
	var direction = Input.get_axis("left", "right")
	
	# 左右移动
	if direction != 0:
		var force_point = Vector2(0, 10)  # 在物体下方施力
		apply_force(Vector2(direction * move_force, 0), force_point)
	
	# 跳跃 - 改成 impulse，注意是负数（向上）
	if Input.is_action_just_pressed("jump") and is_grounded:
		apply_central_impulse(Vector2(0, -jump_impulse))
		is_grounded = false  # 跳跃后立即设为 false，防止连跳
	
	# 空中旋转控制
	if Input.is_action_pressed("left") and not is_grounded:
		apply_torque(-torque_strength * delta)
	elif Input.is_action_pressed("right") and not is_grounded:
		apply_torque(torque_strength * delta)

# 地面检测（关键！）
func _integrate_forces(state):
	is_grounded = false
	
	for i in state.get_contact_count():
		var contact_normal = state.get_contact_local_normal(i)
		# 检查接触法线是否向上（地面在下方）
		# 使用角度判断更可靠
		var angle_to_up = contact_normal.angle_to(Vector2.UP)
		if angle_to_up < deg_to_rad(45):  # 45度以内算地面
			is_grounded = true
			break
	
	# 调试输出（可以删除）
	if Input.is_action_just_pressed("jump"):
		print("跳跃按下！是否在地面：", is_grounded, " 接触点数：", state.get_contact_count())
