extends "res://Scripts/Attacks/Attack.gd"

export var gravity = 60

var ZULUL = preload("res://Scenes/ObjectScenes/ZULUL.tscn")

func _ready():
    
    $AudioStreamPlayer.play()
    get_node("../../AnimatedSprite").play("attack4")
    get_node("../../../BGMPlayer").volume_db -= 5
    
    # Where to instantiate the bullets => outside the sprite
    var sprite_size_offset = get_node("../../AnimatedSprite").frames.get_frame("idle", 0).get_width() * 1.2
    var old_position = get_node("../../").global_position
    
    yield(get_tree().create_timer(0.5, false), "timeout")
    for _i in range(5):
        var ad_instance = ZULUL.instance()
        get_parent().add_child(ad_instance)
        ad_instance.global_position.x = old_position.x
        ad_instance.global_position.y = old_position.y + sprite_size_offset
        ad_instance.speed = 1000 * sign(get_node("../../../Player").position.x - old_position.x )
        ad_instance.gravity = 100
        yield(get_tree().create_timer(0.6, false), "timeout")

    yield(get_tree().create_timer(1, false), "timeout")
    for _i in range(3):
        var ad_instance = ZULUL.instance()
        get_parent().add_child(ad_instance)
        ad_instance.global_position.x = old_position.x
        ad_instance.global_position.y = old_position.y + sprite_size_offset
        ad_instance.speed = 1000 * sign(get_node("../../../Player").position.x - old_position.x )
        ad_instance.gravity = 100
        yield(get_tree().create_timer(0.2, false), "timeout")
    
    get_node("../../../BGMPlayer").volume_db += 5
    get_node("../../AnimatedSprite").play("idle")
    queue_free()
