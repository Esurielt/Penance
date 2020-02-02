extends Container

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Map.connect("new_room",self,"center_map")
	pass # Replace with function body.

#func center_map():
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
