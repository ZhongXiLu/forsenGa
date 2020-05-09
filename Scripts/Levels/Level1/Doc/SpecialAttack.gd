extends Node

var albert = preload("res://Scenes/ObjectScenes/Levels/Level1/Doc/Albert.tscn")
var albert_theme = preload("res://Audio/BGM/Welcome to the Champions Club.ogg")

func _ready():
    
    $AudioStreamPlayer.play()
    get_node("../../../BGMPlayer").stream = albert_theme
    get_node("../../../BGMPlayer").play()

    var albert_instance = albert.instance()
    albert_instance.position.x = get_node("../../").global_position.x - 600
    albert_instance.position.y = get_node("../../").global_position.y
    get_parent().add_child(albert_instance)
    
    yield(get_tree().create_timer(10, false), "timeout") 
    queue_free()
