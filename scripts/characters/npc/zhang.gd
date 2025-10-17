extends Node
@export var level_manager: Node2D


func _on_interact_area_body_entered(body: Node2D) -> void:
	if(level_manager and level_manager.has_method("npc_talking")):
		level_manager.npc_talking()
		
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
