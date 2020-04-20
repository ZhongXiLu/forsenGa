extends RigidBody2D


func _on_Bullet_body_entered(body):
    
    # Update stats (i.e. health) if necessary
    if body.has_node("Stats"):
        body.get_node("Stats").health -= 1
        
    queue_free()

