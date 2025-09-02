extends CharacterBody2D

class_name Player

@onready var player_sprite: Sprite2D = $Sprite2D
@onready var gun_sprite: Sprite2D = $RayCast2D/Sprite2D
@onready var player_camera: Camera2D = %PlayerCamera
@onready var timer: Timer = $Timer

const SPEED = 75
var shoot_on_cooldown = false

func _process(delta: float) -> void:
	var player_position = self.global_position
	var mouse_position = get_global_mouse_position()
	
	gun_sprite.look_at(mouse_position)
	
	#checks if the rotation is on the left side of the screen to flip the sprite
	if gun_sprite.global_rotation > 1.5 or gun_sprite.global_rotation < -1.5:
		gun_sprite.flip_v = true
		player_sprite.flip_h = true
	else:
		gun_sprite.flip_v = false
		player_sprite.flip_h = false

	if Input.is_action_pressed("shoot") and not shoot_on_cooldown:
		const BULLET = preload("res://scenes/bullet.tscn")
		var bullet = BULLET.instantiate()
		bullet.x_direction = cos(gun_sprite.global_rotation)
		bullet.y_direction = sin(gun_sprite.global_rotation)
		bullet.global_rotation = gun_sprite.global_rotation
		bullet.global_position.x = self.global_position.x + bullet.x_direction * 10
		bullet.global_position.y = self.global_position.y + bullet.y_direction * 10
		self.get_parent().add_child(bullet)
		shoot_on_cooldown = true
		timer.start()

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


func _on_timer_timeout() -> void:
	shoot_on_cooldown = false
