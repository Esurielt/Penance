extends Node

class_name Player

signal game_over

var keys = [0]
var p = 10
var in_room = 1
var currentRoom : Room
export var positon = [0 , 0] #input the starting postion
export var Star_Room_Num = [0,0,0,0]
 
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

func move_to(id,room):
	in_room = id
	currentRoom = room
	
func get_key(id):
	keys.append(id)
	
func get_position():
	return positon

func star_room():
	return Star_Room_Num
	
func current_room():
	return currentRoom
	
func peek(dir):
	var text = "you have peeked toward "+dir
	if dir == "up":
		text = currentRoom.up[0]
	elif dir == "down":
		text = currentRoom.down[0]
	elif dir == "left":
		text = currentRoom.left[0]
	else:
		text = currentRoom.right[0]
	return text
	
func try_enter(dir):
	enter_room
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
