extends StaticBody2D

export var bullet_speed = 800
export var fire_rate = 0.2
export var attack_rate = 0.3

var bullet = preload("res://Scenes/ObjectScenes/Doc/NaM.tscn")
var has_fired = false
var player_in_sight = false
    
func _ready():
    $AnimatedSprite.play()
    
func _process(delta):
    
    if player_in_sight and !has_fired:
        has_fired = true
        
        for _i in range(3):
            var bullet_instance = bullet.instance()
            bullet_instance.position.x = global_position.x
            bullet_instance.position.y = global_position.y
            bullet_instance.rotation = get_angle_to(get_tree().root.get_node("World/Player").position) - rotation
            if bullet_instance.rotation > 1.5 or bullet_instance.rotation < -1.5:
                bullet_instance.get_node("Sprite").flip_v = true
            get_parent().add_child(bullet_instance)
            bullet_instance.set_linear_velocity((get_tree().root.get_node("World/Player").position - bullet_instance.position).normalized() * bullet_speed)
            yield(get_tree().create_timer(fire_rate, false), "timeout")
        
        yield(get_tree().create_timer(attack_rate, false), "timeout")
        has_fired = false

func _on_Stats_no_health():
    queue_free()


func player_in_sight(body):
    player_in_sight = true

func player_out_of_sight(body):
    player_in_sight = false
