extends RigidBody2D

# 基础参数
@export var gravity:float=2.5
@export var ground_force: float = 200.0 #地面中心力，现在调整为仅一定程度修正速度
@export var max_angular_velocity: float = 8.0  # 最大旋转速度
@export var jump_impulse: float = 600.0   # 跳跃冲量大小（垂直方向）
@export var jump_direction_strength: float = 0.001  # 水平方向弹射比例
@export var jump_cooldown: float = 0.5     # 跳跃冷却时间
@export var fall_acceleration: float = 3500.0  # 按下↓时的下落加速度
@export var start_torque: float = 5000.0    # 滚动倾斜扭矩，影响地面位移的主要属性！
@export var air_spin_force: float = 100.0   # 空中旋转产生的位移力，唯一影响空中位移的属性！
@export var self_num :int =0
@export var snap_target :Node2D = null
signal jump


# 状态变量
var on_ground: int = 0
var really_on_ground=false
var temp=really_on_ground
var last_jump_time: float = 0.0

func _physics_process(_delta: float) -> void:
	# 处理移动、跳跃和下落加速
	handle_movement()  
	handle_jump()
	handle_fall_acceleration()
	absorb_to_container(_delta) #吸附到数字框
	handle_sfx()
	# 限制最大旋转速度
	angular_velocity = clamp(angular_velocity, -max_angular_velocity, max_angular_velocity)
	


# 整合地面和空中移动逻辑
func handle_movement() -> void:
	if on_ground:
		handle_ground()
	else:
		handle_air_spin()

# 地面滚动逻辑
func handle_ground() -> void:
	if Input.is_action_pressed("left"):
		apply_torque(-start_torque * 5)
		apply_central_force(Vector2(-ground_force, 0))
	elif Input.is_action_pressed("right"):
		apply_torque(start_torque * 5)		
		apply_central_force(Vector2(ground_force, 0))

# 空中旋转产生位移逻辑
func handle_air_spin() -> void:
	if Input.is_action_pressed("left"):
		apply_torque(-start_torque * 5)
		apply_central_force(Vector2(-air_spin_force, 0))  
	elif Input.is_action_pressed("right"):
		apply_torque(start_torque * 5)
		apply_central_force(Vector2(air_spin_force, 0))

# 跳跃处理逻辑（含冷却判断）
func handle_jump() -> void:
	# 检查跳跃冷却
	if (Time.get_ticks_msec() / 1000.0) - last_jump_time < jump_cooldown:
		return
	# 执行跳跃（仅在地面或物体上）
	if Input.is_action_just_pressed("jump") and (on_ground):
		jump.emit()
		# 计算水平方向（左/右）
		var horizontal_dir: float = 0.0
		if Input.is_action_pressed("left"):
			horizontal_dir = -1.0
		elif Input.is_action_pressed("right"):
			horizontal_dir = 1.0
		
		# 构建跳跃向量（水平方向按比例分配冲量）
		var jump_vector: Vector2 = Vector2(
			horizontal_dir * jump_impulse * jump_direction_strength,
			-jump_impulse  # 垂直方向向上（负号对应Godot坐标系）
		)
		
		apply_impulse(jump_vector)
		last_jump_time = Time.get_ticks_msec() / 1000.0
		apply_torque(horizontal_dir * jump_impulse * 0.05)  # 跳跃时附加旋转扭矩

# 下落加速逻辑（按下↓时）
func handle_fall_acceleration() -> void:
	if Input.is_action_pressed("down"):
		apply_central_force(Vector2(0, fall_acceleration))
func absorb_to_container(delta : float) -> void:
	var snap_min_distance : float = 2.0
	var snap_strength: float = 6.25
	if snap_target:
		gravity_scale = 0
		var target_pos = snap_target.global_position
		var dir = target_pos - global_position
		if dir.length() > snap_min_distance:
			global_position += dir * snap_strength * delta
	else:
		gravity_scale = gravity
		
func handle_sfx():
	if really_on_ground==true and abs(linear_velocity.x)>50:
		playsound($move,true)
	else:
		playsound($move,false)
	
	if really_on_ground!=temp and really_on_ground==true:
		playsound($fall,true)
		if is_instance_valid($"../camera"):
			$"../camera".shake(2,0.5)
	temp=really_on_ground		
func playsound(audio,command):
	if not audio.playing and command==true:
		audio.play()
	elif command==false:
		audio.stop()	
