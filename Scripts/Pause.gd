extends CanvasLayer

func _input(event):
    
    if event.is_action_pressed("pause"):
        var paused = !get_tree().paused
        get_tree().paused = paused
        $Control.visible = paused
