extends Node

class_name Room

var ID : int
var Dialogue : String
var PCost : int
var Need_key: Array  ## What room you need to explore to be able to enter this room.
var Give_key: bool
var up :Array   # [String, id]
var down:Array
var left:Array
var right:Array

var Entered = false   # if it's the first time player entering the room

signal collect_star
signal entry_denied

func init(id, dialogue, pcost, needkey, givekey, options):
	ID = id
	Dialogue = dialogue
	PCost = pcost
	Need_key = needkey
	Give_key = givekey
	up = options[0]
	down = options[1]
	left = options[2]
	right = options[3]

func on_enter(player):
	if !player.has_key(Need_key):
		print("entry denied.")
		emit_signal("entry_denied")
		return 
	if !Entered: 
		player.lose_p(PCost)
	player.move_to(ID,self)
	Entered = true
	if Give_key:
		player.get_key(ID)
	if ID in player.star_room():
		emit_signal("collect_star")
	return  #return the room you are currently in.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
