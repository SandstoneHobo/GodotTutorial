extends CharacterBody2D

class_name Player

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var gun_sprite: Sprite2D = $RayCast2D/Sprite2D
@onready var player_camera: Camera2D = %PlayerCamera

const SPEED = 75

func _process(delta: float) -> void:
	var player_position = self.global_position
	var mouse_position = get_global_mouse_position()
	
	#var delta_x = abs(mouse_position.x - player_position.x)
	#var delta_y = abs(mouse_position.y - player_position.y)
	#var angle = abs(atan(delta_y/delta_x))
	
	#var delta_position = mouse_position - player_position
	#var angle = atan2(delta_position.y, delta_position.x)
	
	#ray_cast_2d.rotation = angle
	#gun_sprite.rotation = angle
	
	#print(angle)
	
	gun_sprite.look_at(mouse_position)
	ray_cast_2d.look_at(mouse_position)
	
	if gun_sprite.rotation_degrees > 90 and gun_sprite.rotation_degrees < 270:
		gun_sprite.flip_v = true
	else:
		gun_sprite.flip_v = false
	
	if Input.is_action_pressed("shoot"):
		const BULLET = preload("res://scenes/bullet.tscn")
		var bullet = BULLET.instantiate()
		bullet.global_position.x += 62
		self.get_parent().add_child(bullet)
		

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var h_direction := Input.get_axis("move_left", "move_right")
	var v_direction := Input.get_axis("move_up", "move_down")
	if h_direction:
		velocity.x = h_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if v_direction:
		velocity.y = v_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
