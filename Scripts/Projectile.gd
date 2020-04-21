extends RigidBody2D


func _on_body_entered(body):
    
    print("Entered body")
    
    # Update stats (i.e. health) if necessary
    if body.has_node("Stats"):
        body.get_node("Stats").health -= 1
        
    queue_free()

