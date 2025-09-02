extends Node2D

var SPEED = 20
var x_direction = 0
var y_direction = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += SPEED * x_direction * delta
	position.y += SPEED * y_direction * delta
