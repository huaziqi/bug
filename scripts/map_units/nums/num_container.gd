extends Node

@export var snap_speed: float = 300.0  # 吸附速度
var target_item: Node2D = null
var items_list: Array[Node2D] = []
var in_container_num : int

func _ready():
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("num_item"):
		if(target_item == null):
			body.snap_target = self  # 告诉道具它现在可以吸附到我这里
			target_item = body
			if("self_num" in body):
				in_container_num = body.self_num
		else:
			items_list.append(body)

func _on_body_exited(body: Node2D) -> void:
	if body == target_item:
		body.snap_target = null
		target_item = null
		if(not items_list.is_empty()):
			target_item = items_list[0]
			items_list[0].snap_target = self
			if("self_num" in items_list[0]):
				in_container_num = items_list[0].self_num
			items_list.pop_front()
	elif(body in items_list):
		items_list.erase(body)
