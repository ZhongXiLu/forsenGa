extends KinematicBody2D

export var gravity = 60
export var speed = 600

var motion = Vector2()

func _physics_process(_delta):
    
    motion.y += gravity
    
    if is_on_floor():
        # Wait for ad to be on the ground
        motion.x = speed
        
    motion = move_and_slide(motion, Vector2(0, -1))


func _on_Area2D_body_entered(body):
    if body.get_collision_layer_bit(6): # wall_boundary
        queue_free()
    elif body.has_node("Stats"):
        body.get_node("Stats").health -= 1
        queue_free()
