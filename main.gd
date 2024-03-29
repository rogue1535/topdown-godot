extends Node2D
var target = null
var distarget = 10000

var Playerhp = 1

var manualWeapon = true
var autoWeapon = false
var moltov = false

var enemy_count

var score = 0
var Hp = 10

signal exp
signal damage


func _ready():
	pass


#func _process(delta):
	#enemy_count = get_tree().get_nodes_in_group("enemies").count(" ")


