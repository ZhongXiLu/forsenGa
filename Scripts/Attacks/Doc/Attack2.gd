extends Node

export var drop_speed = 500
export var width_arena = 1100

var spam = preload("res://Scenes/ObjectScenes/Spam.tscn")
var spam_instances = []


func _ready():
    
    $AudioStreamPlayer.play()
    
    # TODO: spam text variations
    # TODO: add 'cvPaste' animation on top of spam
    
    for i in range(2):
        var spam_instance = spam.instance()
        spam_instance.position.x = get_parent().global_position.x - randi()%width_arena +1
        spam_instance.position.y = get_parent().global_position.y - 600
        add_child(spam_instance)
        spam_instance.set_linear_velocity(Vector2(0, drop_speed))
        spam_instances.append(spam_instance)
        yield(get_tree().create_timer(2.5), "timeout")

func _process(_delta):
    if spam_instances.empty():
        queue_free()        # attack is over
