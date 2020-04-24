extends KinematicBody2D

export(Array, Resource) var attacks = []
export(Resource) var specialAttack = null

export var attack_rate = 5

var can_attack = false
var dead = false
var next_attacks = []
var used_special_attack = false


func _ready():
    randomize()     # TODO: move this line somewhere else?
    $Introduction.play()
    yield(get_tree().create_timer(5, false), "timeout")
    can_attack = true


func _process(_delta):
    if can_attack and !dead:
        can_attack = false
        
        if !used_special_attack and float($Stats.health) / $Stats.max_health <= 0.35:
            $Stats.invulnerable = true
            $Attacks.add_child(specialAttack.instance())
            used_special_attack = true
            yield(get_tree().create_timer(6, false), "timeout")
            $Stats.invulnerable = false
        
        yield(get_tree().create_timer(1, false), "timeout")     # small buffer in between attacks
        
        if next_attacks.empty():
            # Create new permutation of attacks
            next_attacks = range(attacks.size())
            next_attacks.shuffle()
            
        if has_node("Attacks"):
            $Attacks.add_child(attacks[next_attacks.pop_front()].instance())


func _physics_process(_delta):
    # Fall down to the ground if dead
    if dead:
        move_and_collide(Vector2(0, 5))


func _on_Stats_no_health():
    $Attacks.queue_free()
    dead = true
    $AnimatedSprite.play("dead")


func attack_finished():
    can_attack = true
