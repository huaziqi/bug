extends RigidBody2D

# 调整速度和跳跃力度
@export var move_speed: float = 200.0
@export var jump_force: float = 400.0
@export var collisions : Array[CollisionShape2D]
@export var sfx : AudioStream
var on_ground: bool = false

func _ready():
	# 冻结旋转
	lock_rotation = true
	# 保留物理模拟，不完全冻结
	freeze_mode = RigidBody2D.FREEZE_MODE_STATIC
	freeze = false
	set_freeze_enabled(false)
	GameState.state=GameState.PLAYING
	GameState.game_initialized.emit()#ui相关全局变量


func _integrate_forces(state):
	var velocity = linear_velocity

	# 左右移动（通过鼠标）
	if Input.is_action_pressed("left"):
		velocity.x = -move_speed
	elif Input.is_action_pressed("right"):
		velocity.x = move_speed
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.1)  # 逐渐停止

	# 跳跃
	if Input.is_action_just_pressed("down") and on_ground:
		#if(sfx):
			#MusicManager.play_sfx(sfx)
		velocity.y = jump_force
		on_ground = false

	linear_velocity = velocity
