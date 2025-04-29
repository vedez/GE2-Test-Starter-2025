extends RigidBody3D

@export var thrust_force = 10.0
@export var rotation_speed = 2.0
var prop_speeds = [0, 0, 0, 0] 

func _physics_process(delta):
	if Input.is_action_pressed("up"):
		apply_central_force(Vector3.UP * thrust_force)
		_update_propellers(true)
	else:
		_update_propellers(false)

	if Input.is_action_pressed("forward"):
		apply_central_force(-transform.basis.z * thrust_force)

	if Input.is_action_pressed("reverse"):
		apply_central_force(transform.basis.z * thrust_force)

	if Input.is_action_pressed("left"):
		apply_torque(Vector3.UP * -rotation_speed)

	if Input.is_action_pressed("right"):
		apply_torque(Vector3.UP * rotation_speed)

func _update_propellers(active):
	for i in range(4):
		prop_speeds[i] = lerp(prop_speeds[i],active 10.0 : 0.0, 0.1)
		$PropArm[i].rotate_y(prop_speeds[i])

func _process(delta):
	# camera // not yet workinhg - ref. github repos
	var target_position = drone.global_transform.origin - drone.global_transform.basis.z * 10 + Vector3.UP * 5
	global_transform.origin = lerp(global_transform.origin, target_position, delta * 5)
	look_at(drone.global_transform.origin, Vector3.UP)
