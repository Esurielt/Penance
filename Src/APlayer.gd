extends Node

class_name Player

signal game_over
signal new_entry
signal collect_star

var keys = {"0":true}
export var p = 3
var in_room = 1
var currentRoom : Room
export var positon = [0 , 0] #input the starting postion
export var Star_Room_Num = [136,171,189,225]
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_keydict(num_of_room):
	for i in range(num_of_room):
		keys[str(i+1)] = false

func has_key(need_keys):
	print(need_keys)
	for i in need_keys:
		if !keys[i]:
			return false
	return true
	
func lose_p(id, cost):
	if keys[str(id)]:
		return
	p = p-cost 
	if p < 0:
		print("game over.")
		emit_signal("game_over")

func move_to(id,room):
	in_room = id
#	currentRoom = room
	var starindex = Star_Room_Num.find(int(id))
	if starindex != -1 and !keys[str(id)]:
		emit_signal("collect_star")
	emit_signal("new_entry")
	
func get_key(id):
	keys[str(id)] = true
	
func get_position():
	return positon

func star_room():
	return Star_Room_Num
	
func current_room(Map):
	return Map.Rooms[str(in_room)]  #
	
func peek(dir, map):
	var text = ""
	var currentRoom = current_room(map)
	if dir == "up":
		if current_room(map).up[1] != 0:
			text = currentRoom.up[0]
			if text == "":
				text = "(Back)"
	elif dir == "down": 
		if current_room(map).down[1] != 0:
			text = currentRoom.down[0]
			if text == "":
				text = "(Back)"
	elif dir == "left":
		if current_room(map).left[1] != 0:
			text = currentRoom.left[0]
			if text == "":
				text = "(Back)"
	elif dir == "right": 
		if current_room(map).right[1] != 0:
			text = currentRoom.right[0]
			if text == "":
				text = "(Back)"
	return text

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
