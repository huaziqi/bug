extends LevelManager
@onready var collision_area: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var checker_area: CollisionShape2D = $StaticBody2D/checker/CollisionShape2D

func npc_talking():
	super.npc_talking()
	player.freezing = false
	call_deferred("enable_collision_shapes")
	Dialogic.timeline_ended.connect(disable_collision_shapes)

func enable_collision_shapes():
	if is_instance_valid(collision_area):
		collision_area.disabled = false
	if is_instance_valid(checker_area):
		checker_area.disabled = false

func disable_collision_shapes():
	if is_instance_valid(collision_area):
		collision_area.disabled = true
	if is_instance_valid(checker_area):
		checker_area.disabled = true
