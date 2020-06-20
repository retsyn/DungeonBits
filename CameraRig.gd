extends Spatial

# Camera rig system.
#
# Each Spatial is a gimbal, tumbled by the mouse.
# No Z on purpose-- There are no Dutch Angles in D&D

onready var gimbalY = get_node("translator/gimbalY")
onready var gimbalX = get_node("translator/gimbalY/gimbalX")
onready var translator = get_node("translator")
onready var cam = get_node("translator/gimbalY/gimbalX/zoomer/Camera")
onready var cursor = get_node("translator/gimbalY/cursor")

export var mouse_sense_x = 0.5
export var mouse_sense_y = 0.5

export var trans_damp_x = 0.4
export var trans_damp_y = 0.4
export var trans_damp_z = 0.4

export var max_y_rot = .6
export var max_x_rot = .6

func _ready():
	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		var cam_xform = cam.get_global_transform()
		var y_xform = gimbalY.get_global_transform()
		var movement = event.relative

		if(Input.is_action_pressed("tumble_mod")):
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

			if(Input.is_action_pressed("translate_mod")):
				translator.translation.x += (movement.x * trans_damp_x) / 100
				translator.translation.y -= (movement.y * trans_damp_y) / 100
			elif(Input.is_action_pressed("truck_mod")):
				translator.translation.z -= (movement.y * trans_damp_z) / 100
			else:
				gimbalY.rotation.y += -deg2rad(movement.x)
				if(gimbalY.rotation.y > max_y_rot):
					gimbalY.rotation.y = max_y_rot
				elif(gimbalY.rotation.y < -max_y_rot):
					gimbalY.rotation.y = -max_y_rot

				gimbalX.rotation.x += -deg2rad(movement.y)
				print(gimbalX.rotation.x)
				if(gimbalX.rotation.x > max_x_rot):
					gimbalX.rotation.x = max_x_rot
				elif(gimbalX.rotation.x < -max_x_rot):
					gimbalX.rotation.x = -max_x_rot



					
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

			cursor.translation.x += (movement.x * mouse_sense_x) / 10
			cursor.translation.y -= (movement.y * mouse_sense_y) / 10


func _process(delta):

	
	pass
