extends Node2D

var player_in_obstacle = null
var can_damage = true
var damage_rate = 1

func raise_water():
    $Water.visible = true
    for i in range(100):
        modulate = Color(1, 1, 1, float(i) / 100)
        yield(get_tree().create_timer(0.01, false), "timeout")
    $CollisionShape2D.disabled = false
    $CollisionShape2D2.disabled = false
    
func lower_water():
    $CollisionShape2D.disabled = true
    $CollisionShape2D2.disabled = true
    for i in range(100, 0, -1):
        modulate = Color(1, 1, 1, float(i) / 100)
        yield(get_tree().create_timer(0.01, false), "timeout")
    $Water.visible = false

func _on_Water_body_entered(body):
    if body.get_collision_layer_bit(1): # player
        player_in_obstacle = body
        
        # Add small movement debuff
        player_in_obstacle.gravity /= 3
        player_in_obstacle.max_speed /= 3
        player_in_obstacle.acceleration /= 3


func _on_Water_body_exited(body):
    if body.get_collision_layer_bit(1): # player
        # Restore debuff
        body.gravity *= 3
        body.max_speed *= 3
        body.acceleration *= 3
        
        player_in_obstacle = null


func _process(delta):
    if player_in_obstacle and can_damage:
        can_damage = false
        player_in_obstacle.get_node("Stats").health -= 1
        yield(get_tree().create_timer(damage_rate, false), "timeout")
        can_damage = true
