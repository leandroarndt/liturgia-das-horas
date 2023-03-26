extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var instrumentos:Dictionary = {}
var leitor_sf = preload("res://addons/midi/SoundFont.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var sf = leitor_sf.read_file("res://assets/instrumentos.sf2")
	for inst in sf.pdta.phdr:
		if inst.preset != 255: # Fim dos presets
			instrumentos[inst.preset] = inst.name
	for obj in [$OrganizadorConfiguracoes/GradeConfiguracoes/InstrumentoMelodia, $OrganizadorConfiguracoes/GradeConfiguracoes/InstrumentoHarmonia]:
		for inst in instrumentos.keys():
			obj.add_item(instrumentos[inst], inst)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
