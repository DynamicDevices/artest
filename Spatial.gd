extends Spatial

var arvrinterface = null
var arvrinterfacename = "none"

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
			
func _input(event):
	
	if Input.is_action_pressed("cube_left"):
		$Cube.translate(Vector3(1,0,0))
	elif Input.is_action_pressed("cube_right"):
		$Cube.translate(Vector3(-1,0,0))
	elif Input.is_action_pressed("cube_up"):
		$Cube.translate(Vector3(0,1,0))
	elif Input.is_action_pressed("cube_down"):
		$Cube.translate(Vector3(0,-1,0))

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
