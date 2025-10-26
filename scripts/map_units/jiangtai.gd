extends RigidBody2D
@onready var zhang: RigidBody2D = $"../Zhang"
@onready var jiangtai: RigidBody2D = $"."
@onready var desk: RigidBody2D = $"../desk"
@onready var player: RigidBody2D = $"../Steel_Pipe"
@export var on_class : AudioStream

var static_player : bool = false
var listended : bool = false
@onready var level_2: Node2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	desk.lock_rotation = true
	# 保留物理模拟，不完全冻结
	desk.freeze_mode = RigidBody2D.FREEZE_MODE_STATIC
	zhang.interact.connect(listen_class)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):

		static_player = false
		player.gravity_scale = player.gravity
		player.lock_rotation = false
		player.hand.get_node("AnimatedSprite2D").flip_h = false

func _physics_process(delta: float) -> void:
	if(not level_2.in_change and player.global_position.y > 700):
		print(player.global_position.y)
		player.global_position.y = 0
	if(static_player):
		player.position = desk.position + Vector2(20, -20)
		player.hand.global_position = player.global_position + Vector2(-30, 0)
		player.hand.global_rotation = 0  # 固定旋转
		player.hand.get_node("AnimatedSprite2D").flip_v = true
		player.hand.get_node("AnimatedSprite2D").flip_h = true
		for body in player.hand.target_rigidbodies:
			if is_instance_valid(body) and "modulate" in body:
				body.modulate.a = 1
		player.hand.target_rigidbodies.clear()
		player.hand.temp_target_rigidbodies.clear()

func listen_class():
	if(not listended):
		MusicManager.play_sfx(on_class)
		jiangtai.gravity_scale = 1
		desk.gravity_scale = 1
		static_player = true
		player.gravity_scale = 0
		player.lock_rotation = true
		listended = true
		# 强制停止手的物理运动




	
