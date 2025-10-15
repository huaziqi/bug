extends Node
@export var nums : Array[Node2D]
@export var ans_label : Label

var caculable: bool = false
var num1 : Array[int]
var num2 : Array[int]


func _physics_process(delta: float) -> void:
	get_num()
	if(caculable):
		var ans = calc()
		ans_label.text = str(ans)
	else:
		ans_label.text = ""
	
	
func get_num():
	caculable = false
	var cnt : int = 0
	num1.clear()
	num2.clear()
	for node in nums:
		cnt += 1
		if("target_item" in node and node.target_item != null):
			if(1 <= cnt and cnt <= 2):
				num1.append(node.in_container_num)
			if(3 <= cnt and cnt <= 4):
				num2.append(node.in_container_num)
	if(not(num1.is_empty() or num2.is_empty())):
		caculable = true

func calc() -> float:
	var div_num : int = 0
	var divven_num : int = 0
	for i in num1:
		div_num = div_num * 10 + i
	for i in num2:
		divven_num = divven_num * 10 + i
		
	var ans : float = div_num * 1.0 / divven_num * 1.0
	return ans
