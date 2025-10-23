extends Node
@export var level_manager: Node2D

@export var player : Node2D

var in_area : bool = false

func _physics_process(delta: float) -> void:
	print(in_area)

func _input(event: InputEvent) -> void:
	if(event.is_action("down") and in_area):
		if(level_manager and level_manager.has_method("npc_talking")):
			level_manager.npc_talking()

func _on_interact_area_body_entered(body: Node2D) -> void:
	in_area = true
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	in_area = false
