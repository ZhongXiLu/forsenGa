extends KinematicBody2D

export(Array, Resource) var attacks = []

var can_attack = false
var next_attacks = []

func _ready():

    $Sprite.visible = true
    
    for i in range(300):
        $Sprite.modulate = Color(1, 1, 1, float(i) / 300)
        yield(get_tree().create_timer(0.01, false), "timeout")

    can_attack = true

func _process(_delta):
    if can_attack:
        can_attack = false
        
        yield(get_tree().create_timer(4, false), "timeout")     # buffer in between attacks
        
        if next_attacks.empty():
            # Create new permutation of attacks
            next_attacks = range(attacks.size())
            next_attacks.shuffle()
            
        if has_node("Attacks"):
            $Attacks.add_child(attacks[next_attacks.pop_front()].instance())

func attack_finished():
    can_attack = true
