extends KinematicBody
class_name piece

export var trans_damp_x = 0.1
export var trans_damp_y = 0.1
export var trans_damp_z = 0.1

enum piece_states{
	placed = 0,
	picked_up,
	hidden,
}

var state = piece_states.placed
var hilite = false

var held = false

var base_colour
var hilite_colour

var material = SpatialMaterial.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	base_colour = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1))
	hilite_colour = (base_colour + Color(0.4, 0.4, 0.4))
	$MeshInstance.set_surface_material(0, material)


func _physics_process(delta):
	# Make that piece do shit
	if(held):
		$MeshInstance.translation.y = 0.05
	else:
		$MeshInstance.translation.y = 0
		
	if(hilite):
		var material = $MeshInstance.get_surface_material(0)
		material.albedo_color = hilite_colour
		$MeshInstance.set_surface_material(0, material)
	
	if(!hilite):
		var material = $MeshInstance.get_surface_material(0)
		material.albedo_color = base_colour
		$MeshInstance.set_surface_material(0, material)
	
	if(Input.is_action_just_pressed("mouse_click_left")):
		if(!held):
			if(hilite):
				held = true
		else:
			if(held):
				held = false
			
				
	
			


		
	call_deferred('de_hilite')


func _input(event):
	if event is InputEventMouseMotion:
		if(held):
			var movement = event.relative
			translation.x += (movement.x * trans_damp_x) / 100
			translation.z += (movement.y * trans_damp_y) / 100
			


func de_hilite():
	hilite = false



func user_input(event):
	# Requires child nodes to have input event signals.
	if event is InputEventMouseMotion:
		hilite = true
