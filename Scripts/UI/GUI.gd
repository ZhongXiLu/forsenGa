extends CanvasLayer

export var forsenE = preload("res://Scenes/ObjectScenes/forsenE.tscn")

func _on_Player_Stats_health_init(health):
    _on_Player_Stats_health_changed(health)

func _on_Player_Stats_health_changed(health):
    var health_node = get_node("PlayerHealth")
    
    if health_node.get_child_count() > health:
        # Remove health
        while health_node.get_child_count() != health:
            health_node.remove_child(health_node.get_child(health_node.get_child_count() - 1))
        
    elif health_node.get_child_count() < health:
        # Add health
        while health_node.get_child_count() != health:
            health_node.add_child(forsenE.instance())


func _on_Boss_Stats_health_init(health):
    var health_node = get_node("CenterContainer/EnemyHealth")
    health_node.max_value = health
    _on_Boss_Stats_health_changed(health)
    
func _on_Boss_Stats_health_changed(health):
    var health_node = get_node("CenterContainer/EnemyHealth")
    health_node.value = health
    get_node("CenterContainer/EnemyHealth/CenterContainer/EnemyHealthValue").text = str(health)


func _on_Player_Stats_no_health():
    $Retry.visible = true

func _on_Retry_pressed():
    get_tree().reload_current_scene()
