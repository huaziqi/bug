extends Node
@onready var collision_area: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var checker_area: CollisionShape2D = $StaticBody2D/checker/CollisionShape2D
func _ready() -> void:
	GameState.state=GameState.PLAYING
	GameState.game_initialized.emit()#ui相关全局变量
func npc_talking():
	Dialogic.start("level_2")
	call_deferred("enable_collision_shapes")

func enable_collision_shapes():
	if is_instance_valid(collision_area):
		collision_area.disabled = false
	if is_instance_valid(checker_area):
		checker_area.disabled = false
