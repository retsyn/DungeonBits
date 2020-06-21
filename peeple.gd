extends piece


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_nametag()


func move_nametag():
	var tag_pos = $LabelTrans.get_global_transform().origin
	#var tag_pos = self.translation
	var cam = get_viewport().get_camera()
	var screen_pos = cam.unproject_position(tag_pos)
	screen_pos.x -= ($LabelTrans/Label.rect_size.x / 2)
	screen_pos.y -= 10
	$LabelTrans/Label.rect_position = screen_pos

func _on_Peeple_mouse_entered():
	print ("You pickin!")


func _on_Peeple_input_event(camera, event, click_position, click_normal, shape_idx):
	user_input(event)
