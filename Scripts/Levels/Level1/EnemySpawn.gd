extends Node

var vietNaM = preload("res://Scenes/ObjectScenes/Levels/Level1/vietNaM.tscn")
var NaMSignal = preload("res://Scenes/ObjectScenes/Levels/Level1/NaMSignal.tscn")
var Nammies = preload("res://Scenes/ObjectScenes/Levels/Level1/Nammies.tscn")
var NaMPls = preload("res://Scenes/ObjectScenes/Levels/Level1/NaMPls.tscn")

var spawned_enemies = false


func _ready():
    $Door.visible = false


func spawn_enemy(enemy, spawn_location):
    var enemy_instance = enemy.instance()
    get_parent().add_child(enemy_instance)
    enemy_instance.global_position.x = spawn_location.global_position.x
    enemy_instance.global_position.y = spawn_location.global_position.y
    return enemy_instance

func spawn_enemies():
    $Door.visible = true
    
    # Hardcode collisions
    $Door.set_collision_layer_bit(0, true)
    $Door.set_collision_mask_bit(1, true)
    $Door.set_collision_mask_bit(2, true)
    $Door.set_collision_mask_bit(3, true)
    $Door.set_collision_mask_bit(4, true)
    
    var cur_wave = []
    
    # Spawn enemies
    cur_wave.append(spawn_enemy(vietNaM, $SpawnPoint1))
    cur_wave.append(spawn_enemy(vietNaM, $SpawnPoint2))
    
    while cur_wave:
        var enemies_still_alive = false
        for enemy in cur_wave:
            if weakref(enemy).get_ref():
                enemies_still_alive = true
        
        if not enemies_still_alive:
            break
        
        yield(get_tree().create_timer(0.4, false), "timeout")
        
    cur_wave.append(spawn_enemy(NaMPls, $SpawnPoint1))
    cur_wave.append(spawn_enemy(NaMPls, $SpawnPoint2))
    
    while cur_wave:
        var enemies_still_alive = false
        for enemy in cur_wave:
            if weakref(enemy).get_ref():
                enemies_still_alive = true
        
        if not enemies_still_alive:
            break
        
        yield(get_tree().create_timer(0.4, false), "timeout")

    var e1 = spawn_enemy(NaMSignal, $SpawnPoint3)
    e1.rotation = -2.5
    cur_wave.append(e1)
    var e2 = spawn_enemy(NaMSignal, $SpawnPoint4)
    e2.rotation = 2.5
    cur_wave.append(e2)
    cur_wave.append(spawn_enemy(Nammies, $SpawnPoint2))
    
    while cur_wave:
        var enemies_still_alive = false
        for enemy in cur_wave:
            if weakref(enemy).get_ref():
                enemies_still_alive = true
        
        if not enemies_still_alive:
            break
        
        yield(get_tree().create_timer(0.4, false), "timeout")
        
    $Door.queue_free()


func _on_Area2D_body_entered(body):
    if not spawned_enemies:
        spawn_enemies()
    spawned_enemies = true
