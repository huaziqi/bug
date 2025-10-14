extends CharacterBody2D

# 移动参数
@export var speed = 300.0
@export var jump_velocity = -400.0

# 获取重力值
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# 添加重力
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# 处理跳跃
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# 获取输入方向：-1（左）、0（不动）、1（右）
	var direction = Input.get_axis("left", "right")
	
	# 应用移动
	if direction != 0:
		velocity.x = direction * speed
	else:
		# 停止时的减速效果
		velocity.x = move_toward(velocity.x, 0, speed)
	
	# 移动角色
	move_and_slide()
