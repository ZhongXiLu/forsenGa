extends "res://Scripts/Attacks/Attack.gd"


export var bullet_speed = 600

var bullet = preload("res://Scenes/ObjectScenes/Card.tscn")

func _ready():
    
    var parent = get_node("../../")
    
    # Where to instantiate the bullets => outside the sprite
    var sprite_size_offset = get_node("../../Sprite").texture.get_size().y * 1.2
    var bullet_instance = bullet.instance()
    bullet_instance.position.x = parent.global_position.x
    bullet_instance.position.y = parent.global_position.y + sprite_size_offset
    bullet_instance.rotation = parent.get_angle_to(get_tree().root.get_node("World/Player").position) + parent.rotation
    if bullet_instance.rotation > 1.5 or bullet_instance.rotation < -1.5:
        bullet_instance.get_node("Sprite").flip_v = true
    get_parent().add_child(bullet_instance)
    bullet_instance.set_linear_velocity((get_tree().root.get_node("World/Player").position - bullet_instance.position).normalized() * bullet_speed)
    
    for i in range(100, 0, -1):
        if weakref(bullet_instance).get_ref():
            bullet_instance.get_node("Sprite").modulate = Color(1, 1, 1, float(i) / 100)
            yield(get_tree().create_timer(0.01, false), "timeout")
    
    queue_free()
