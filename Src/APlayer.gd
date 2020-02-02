extends Node

class_name Player

var keys = [0]
var p = 10
var in_room = 1

signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func has_key(need_keys):
	for i in need_keys:
		if !(i in keys):
			return false
	return true
	
func lose_p(cost):
	p = p-cost 
	if p < 0:
		print("game over.")
		emit_signal("game_over")

func move_to(id):
	in_room = id
	
func get_key(id):
	keys.append(id)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
