extends KinematicBody2D

export var freq = 5
export var amplitude = 1500
export var direction = 1
export var is_cos = true

var time = 0

func _physics_process(delta):
    
    time += delta
    
    var velocity = Vector2(direction * 800, 0)
    if is_cos:
        velocity.y = cos(time * freq) * amplitude
    else:
        velocity.y = sin(time * freq) * amplitude        
    move_and_slide(velocity)


func _on_Area2D_body_entered(body):
    if body.get_collision_layer_bit(6): # wall_boundary
        queue_free()
    elif body.has_node("Stats"):
        body.get_node("Stats").health -= 1
        queue_free()
