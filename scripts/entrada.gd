extends Node

class_name Entrada
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var nome_notas = {
	'sis': 72,
	'si': 71,
	'sib': 70,
	'las': 70,
	'la': 69,
	'lab': 68,
	'sols': 68,
	'sol': 67,
	'solb': 66,
	'fas': 66,
	'fa': 65,
	'fab': 64,
	'mis': 65,
	'mi': 64,
	'mib': 63,
	'res': 63,
	're': 62,
	'reb': 61,
	'dos': 61,
	'do':  60,
	'dob': 59,
}
var nome_oitavas = {
	",,": -24,
	",":  -12,
	"'":   12,
	"''":  24,
}
var nome_modos = {
	'': [-12,4,7],
	'7': [-12,4,7,10],
	'7M': [-12,4,7,11],
	'7maj': [-12,4,7,11],
	'maj': [-12,4,7],
	'm': [-12,3,7],
	'min': [-12,3,7],
	'min7': [-12,3,7,10],
	'm7': [-12,3,7,10],
	'min6': [-12,3,9],
	'm6': [-12,3,9],
	'o': [-12,3,6,9],
	'dim': [-12,3,6,9],
}

var notas:Array
var duracao:int
var ligadura:bool = false
var ponto_simples:bool = false
var ponto_duplo:bool = false
var tercina:bool = false

func processar(entrada:String, harmonia:bool):
#		print(entrada)
	var interpretar = RegEx.new()
	interpretar.compile("^(?<tercina>\\\\tuplet\\s+3\\/2\\s*{\\s*)?(?<nota>dob|dos|do|reb|res|re|mib|mis|mi|fab|fas|fa|solb|sols|sol|lab|las|la|sib|sis|si|r)(?<oitava>,,|,|''|')?(?<duracao>(\\d|\\\\breve))?(:(?<modo>\\S+))?(?<ponto>\\.{1,2})?(?<ligadura>~)?")
	var partes = interpretar.search_all(entrada)
#		if not harmonia:
#			print(partes[0].get_string("nota"))
	if partes[0].get_string("nota") != 'r':
		self.notas = [nome_notas[partes[0].get_string("nota")],]
		if harmonia and self.notas[0] >= 68: # Lá bemol:
			self.notas[0] -= 12
	else:
		self.notas = []
	if "oitava" in partes[0].get_names():
		self.notas[0] += nome_oitavas[partes[0].get_string("oitava")]
	if "duracao" in partes[0].get_names():
		if partes[0].get_string("duracao") == "\\breve":
			duracao = Globais.breve
		else:
			duracao = Globais.semibreve / int(partes[0].get_string("duracao"))
	if 'tercina' in partes[0].get_names():
#			print ('tercina: ', duracao, ' * 2/3')
#			duracao *= 2/3
#			print (duracao)
#			print('tercina (entrada.processar)')
		tercina = true
	if "ponto" in partes[0].get_names():
		if partes[0].get_string('ponto') == '.':
#				duracao *= 1.5
			ponto_simples = true
#				print('ponto simples (entrada.processar)')
		else:
#				duracao *= 1.75
			ponto_duplo = true
#				print('ponto duplo (entrada.processar)')
	if "ligadura" in partes[0].get_names():
		ligadura = true
	var modo = ''
	if "modo" in partes[0].get_names():
		modo = partes[0].get_string("modo")
	if harmonia and notas: # harmonia e não pausa
		for n in nome_modos[partes[0].get_string("modo")]:
			self.notas.append(self.notas[0]+n)

func _to_string():
	var retorno:String = ''
	for nota in notas:
		for nome in nome_notas.keys():
			if nome_notas[nome] == nota:
				retorno += nome + ', '
	return retorno

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
