extends Spatial

# Camera rig system.
#
# Each Spatial is a gimbal, tumbled by the mouse.
# No Z on purpose-- There are no Dutch Angles in D&D

onready var gimbalY = get_node("translator/gimbalY")
onready var gimbalX = get_node("translator/gimbalY/gimbalX")
onready var translator = get_node("translator")
onready var cam = get_node("translator/gimbalY/gimbalX/zoomer/Camera")


func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseMotion:
		var cam_xform = cam.get_global_transform()
		var movement = event.relative
		
		if(Input.is_action_pressed("tumble_mod")):

			if(Input.is_action_pressed("translate_mod")):
				translator.translation += (cam_xform.basis * Vector3(movement.x, 0, 0))
				translator.translation -= (cam_xform.basis * Vector3(0, 0, movement.y))
			elif(Input.is_action_pressed("truck_mod")):
				translator.translation -= (cam_xform.basis * Vector3(0, movement.y, 0))
				
				
			else:
				gimbalY.rotation.z += -deg2rad(movement.x)
				gimbalX.rotation.x += -deg2rad(movement.y)
			
			
		


func _process(delta):
	# Camera takes mouse input. 
	pass
