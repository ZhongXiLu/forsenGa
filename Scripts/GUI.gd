extends CanvasLayer

export var forsenE = preload("res://Scenes/ObjectScenes/forsenE.tscn")


func _on_Stats_health_changed(health):
    var health_node = get_node("MarginContainer/Health")
    
    if health_node.get_child_count() > health:
        # Remove health
        while health_node.get_child_count() != health:
            health_node.remove_child(health_node.get_child(health_node.get_child_count() - 1))
        
    elif health_node.get_child_count() < health:
        # Add health
        while health_node.get_child_count() != health:
            health_node.add_child(forsenE.instance())
