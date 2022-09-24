extends Node2D

"""
Actor.gd is the script that controls "Actors", specifically charcters that can deliver dialogue in a cutscene type prompt.
Use scene inheritance to utilize the scene associated with this script. This means inheriting from Actor.tscn, not Actor.gd.
"""

class_name Actor

onready var Pose = $Pose
onready var StagePositionTween = $StagePositionTween
onready var ActorTransitionTween = $ActorTransitionTween
export (String) var actor_name #The actor's name. This is to be set in the inherited scene within the editor, not within script.
signal event_complete
signal start_dialog

#Enums for preset stage_positions, in pixel coordinates.
enum {
	STAGE_POSITION_LEFT = 360, #Left
	STAGE_POSITION_ZERO = 960, #Center
	STAGE_POSITION_RIGHT = 1560 #Right
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#Set the actor's current pose/expression.
func set_pose(pose: int):
	Pose.set("frame", pose)

#Set the position of the actor. Pass enums such as STAGE_POSITION_ZERO, or the position in pixel coordinates.
func set_stage_position(stage_position: float):
#	var target = Vector2(stage_position, Pose.position.y)
#	StagePositionTween.interpolate_property(Pose, "position:x", Pose.position.x, stage_position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	StagePositionTween.start()
	Pose.position.x = stage_position

#Set actor transition to fade in/out and speed of transition
func set_transition(fade: String, f_speed: float):
	if fade == 'fade_in':
		ActorTransitionTween.interpolate_property(Pose, "modulate:a", 0, 1, f_speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	elif fade == 'fade_out':
		ActorTransitionTween.interpolate_property(Pose, "modulate:a", Pose.modulate.a, 0, f_speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	ActorTransitionTween.start()

#Start the actor's dialog so that the actor is speaking. This emits a signal to the dialog box 
#assuming the actor is binded to the box via the connect function.
func start_dialog(dialog: String):
	emit_signal("start_dialog", actor_name, dialog)
	
#Flip the actor horizontally.
func flip_horizontal():
	Pose.set("flip_h", not Pose.get("flip_h"))
	
