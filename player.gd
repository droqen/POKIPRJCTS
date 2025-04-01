extends Node2D

@onready var spr = $SheetSprite
@onready var mover = $NavdiBodyMover
@onready var solidcast = $NavdiBodyMover/ShapeCast2D
var vx : float = 0; var vy : float = 0;
enum {FLORBUF,JUMPBUF}
@onready var bufs = Bufs.Make(self).setup_bufons([
	FLORBUF,4,
	JUMPBUF,4,
])

func _physics_process(_delta: float) -> void:
	if Pin.get_jump_hit(): bufs.on(JUMPBUF)
	if vy>=0 and mover.cast_fraction(self,solidcast,VERTICAL,1)<1: bufs.on(FLORBUF)
	var dpad = Pin.get_dpad() as Vector2
	if dpad.x:
		spr.flip_h = dpad.x < 0
	vx = move_toward(vx, dpad.x, 0.1)
	vy = move_toward(vy, 2.0, 0.04)
	if!mover.try_slip_move(self, solidcast, HORIZONTAL, vx):
		vx = 0
	if!mover.try_slip_move(self, solidcast, VERTICAL, vy):
		vy = 0
	if bufs.try_eat([FLORBUF,JUMPBUF]):
		vy = -1.0
