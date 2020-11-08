extends Spatial

var arvrinterface = null
var arvrinterfacename = "none"

var k1;
var k2;
var display_to_lens;
var display_width;
var eye_height;
var iod;
var oversample;
var dihedral;

func checkloadinterface(larvrinterfacename):
	var available_interfaces = ARVRServer.get_interfaces()
	for x in available_interfaces:
		if x["name"] == larvrinterfacename:
			arvrinterface = ARVRServer.find_interface(larvrinterfacename)
			if arvrinterface != null:
				arvrinterfacename = larvrinterfacename
				print("Found VR interface ", x)
				return true
	return false

func _ready():
	print("  Available Interfaces are %s: " % str(ARVRServer.get_interfaces()))
	if checkloadinterface("Native mobile AR"):
		print("found nativemobile, initializing")
		if arvrinterface.initialize():

			var viewport = get_viewport()
			viewport.arvr = true
			viewport.render_target_v_flip = false # <---- for your upside down screens
			#viewport.transparent_bg = true       # <--- For the AR
			arvrinterface.k1 = 0.5          # Lens distortion constants
			arvrinterface.k2 = 0.23
			#arvrinterface.display_to_lens
			#arvrinterface.display_width
			#arvrinterface.eye_height
			#arvrinterface.iod
			#arvrinterface.oversample

			# Store parameters for reset function
			k1 = arvrinterface.k1
			k2 = arvrinterface.k2
			display_to_lens = arvrinterface.display_to_lens
			display_width = arvrinterface.display_width
			eye_height = arvrinterface.eye_height
			iod = arvrinterface.iod
			oversample = arvrinterface.oversample
			dihedral = arvrinterface.dihedral
						
func _input(event):
	
	if Input.is_action_pressed("cube_left"):
		$Cube.translate(Vector3(1,0,0))
	elif Input.is_action_pressed("cube_right"):
		$Cube.translate(Vector3(-1,0,0))
	elif Input.is_action_pressed("cube_up"):
		$Cube.translate(Vector3(0,1,0))
	elif Input.is_action_pressed("cube_down"):
		$Cube.translate(Vector3(0,-1,0))
	elif Input.is_action_pressed("cube_rotate_inc_x"):
		$Cube.rotate(Vector3(1,0,0),0.1)
	elif Input.is_action_pressed("cube_rotate_dec_x"):
		$Cube.rotate(Vector3(1,0,0),-0.1)
	elif Input.is_action_pressed("cube_rotate_inc_y"):
		$Cube.rotate(Vector3(0,1,0),0.1)
	elif Input.is_action_pressed("cube_rotate_dec_y"):
		$Cube.rotate(Vector3(0,1,0),-0.1)
	elif Input.is_action_pressed("cube_rotate_inc_z"):
		$Cube.rotate(Vector3(0,0,1),0.1)
	elif Input.is_action_pressed("cube_rotate_dec_z"):
		$Cube.rotate(Vector3(0,0,1),-0.1)

	elif Input.is_action_pressed("k1_inc"):
		arvrinterface.k1 += 0.1
	elif Input.is_action_pressed("k1_dec"):
		arvrinterface.k1 -= 0.1
	elif Input.is_action_pressed("k2_inc"):
		arvrinterface.k2 += 0.1
	elif Input.is_action_pressed("k2_dec"):
		arvrinterface.k2 -= 0.1
	elif Input.is_action_pressed("display_to_lens_inc"):
		arvrinterface.display_to_lens += 0.1
	elif Input.is_action_pressed("display_to_lens_dec"):
		arvrinterface.display_to_lens -= 0.1
	elif Input.is_action_pressed("display_width_inc"):
		arvrinterface.display_width += 0.1
	elif Input.is_action_pressed("display_width_dec"):
		arvrinterface.display_width -= 0.1
	elif Input.is_action_pressed("eye_height_inc"):
		arvrinterface.eye_height += 0.1
	elif Input.is_action_pressed("eye_height_dec"):
		arvrinterface.eye_height -= 0.1
	elif Input.is_action_pressed("iod_inc"):
		arvrinterface.iod += 0.1
	elif Input.is_action_pressed("iod_dec"):
		arvrinterface.iod -= 0.1
	elif Input.is_action_pressed("oversample_inc"):
		arvrinterface.oversample += 0.1
	elif Input.is_action_pressed("oversample_dec"):
		arvrinterface.oversample -= 0.1
	elif Input.is_action_pressed("dihedral_inc"):
		arvrinterface.dihedral += 0.1
	elif Input.is_action_pressed("dihedral_dec"):
		arvrinterface.dihedral -= 0.1

	elif Input.is_action_pressed("help"):
		print("Keys:")
		print("		H - this help text")
		print("		C - reset parameters")
		print("		V - view parameter values")
		print("		Left Arrow - move cube left (x)")
		print("		Right Arrow - move cube right (y)")
		print("		Up Arrow - move cube up (y)")
		print("		Down Arrow - move cube down (z)")
		print("		KP5 - rotate cube inc (x)")
		print("		KP6 - rotate cube dec (x)")
		print("		KP2 - rotate cube inc (y)")
		print("		KP3 - rotate cube dec (y)")
		print("		KP0 - rotate cube inc (z)")
		print("		KP. - rotate cube dec (z)")
		print("		1 - increment k1")
		print("		2 - decrement k1")
		print("		3 - increment k2")
		print("		4 - decrement k2")
		print("		5 - increment display_to_lens")
		print("		6 - decrement display_to_lens")
		print("		7 - increment display_width")
		print("		8 - decrement display_width")
		print("		9 - increment eye_heigth")
		print("		0 - decrement eye_height")
		print("		Q - increment iod")
		print("		W - decrement iod")
		print("		E - increment oversample")
		print("		R - decrement oversample")
		print("		O - increment dihedral")
		print("		P - decrement dihedral")
	elif Input.is_action_pressed("reset_parameters"):
			arvrinterface.k1 = k1
			arvrinterface.k2 = k2
			arvrinterface.display_to_lens = display_to_lens
			arvrinterface.display_width = display_width
			arvrinterface.eye_height = eye_height
			arvrinterface.iod = iod
			arvrinterface.oversample = oversample
			arvrinterface.dihedral = dihedral
	elif Input.is_action_pressed("view_parameters"):
			print("Current Parameters:")
			print("		k1 = " + String(arvrinterface.k1))
			print("		k2 = " + String(arvrinterface.k2))
			print("		display_to_lens = " + String(arvrinterface.display_to_lens))
			print("		display_width = " + String(arvrinterface.display_width))
			print("		eye_height = " + String(arvrinterface.eye_height))
			print("		iod = " + String(arvrinterface.iod))
			print("		oversample = " + String(arvrinterface.oversample))
			print("		dihedral = " + String(arvrinterface.dihedral))

