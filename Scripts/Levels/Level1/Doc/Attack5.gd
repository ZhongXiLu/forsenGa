extends "res://Scripts/Levels/Attack.gd"

var dolphin = preload("res://Scenes/ObjectScenes/Levels/Level1/Doc/Dolphin.tscn")
var dolphin_instances = []

const SPAWN_POSITIONS = [[Vector2(2040, 816), false], [Vector2(360, 816), true]]

signal raise_water
signal lower_water

func _ready():
    
    $AudioStreamPlayer.play()
    get_node("../../AnimatedSprite").play("attack5")
    connect("raise_water", get_node("../../../Env/Water"), "raise_water")
    emit_signal("raise_water")
    
    # Spawn dolphins at spawn location
    var rngs = [sign(rand_range(-1, 1)), randi() % 2]
    for spawn_position in SPAWN_POSITIONS:
        var dolphin_instance = dolphin.instance()
        get_parent().add_child(dolphin_instance)
        dolphin_instance.rngs = rngs
        dolphin_instance.global_position = spawn_position[0]
        dolphin_instance.get_node("Sprite").flip_h = spawn_position[1]
        dolphin_instance.target_position = dolphin_instance.global_position.y - 250
        dolphin_instances.append(dolphin_instance)
    
    
    yield(get_tree().create_timer(3, false), "timeout")
    
    # Bring down the dolphins
    for dolphin_instance in dolphin_instances:
        dolphin_instance.destroy = true
    
    # Bring down the water
    connect("lower_water", get_node("../../../Env/Water"), "lower_water")
    emit_signal("lower_water")
    
    yield(get_tree().create_timer(1, false), "timeout")
    
    get_node("../../AnimatedSprite").play("idle")
    queue_free()
