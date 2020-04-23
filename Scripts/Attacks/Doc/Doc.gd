extends KinematicBody2D

export(Array, Resource) var attacks = []

export var attack_rate = 5

var can_attack = false
var dead = false
var next_attacks = []


func _ready():
    randomize()     # randomize seed here
    $Introduction.play()
    yield(get_tree().create_timer(5, false), "timeout")
    can_attack = true


func _process(_delta):
    if can_attack and !dead:
        can_attack = false

        if next_attacks.empty():
            # Create new permutation of attacks
            next_attacks = range(attacks.size())
            next_attacks.shuffle()
            
        $Attacks.add_child(attacks[next_attacks.pop_front()].instance())
        
        # TODO: wait for attack to finish
        yield(get_tree().create_timer(attack_rate, false), "timeout")
        can_attack = true


func _physics_process(_delta):
    # Fall down to the ground if dead
    if dead:
        move_and_collide(Vector2(0, 5))


func _on_Stats_no_health():
    $Attacks.queue_free()
    dead = true
    $AnimatedSprite.play("dead")
