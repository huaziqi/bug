extends Node
@export var nums : Array[Node2D]
@export var ans_label : Label

var caculable: bool = false
var zero_error: bool = false
var num1 : Array[int]
var num2 : Array[int]


func _physics_process(delta: float) -> void:
	get_num()
	if(caculable and not zero_error):
		ans_label.text = calc()
	elif(not caculable and not zero_error):
		ans_label.text = "?"
	elif(zero_error):
		pass
	
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

func calc() -> String:
	var div_num : int = 0
	var divven_num : int = 0
	for i in num1:
		div_num = div_num * 10 + i
	for i in num2:
		divven_num = divven_num * 10 + i
	if(divven_num == 0):
		zero_error = true
		return "warning: division by zero"
	else:
		var res : float = div_num * 1.0 / divven_num * 1.0
		var ans : String = String.num(res, 3)
		return ans
