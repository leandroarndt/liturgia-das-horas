extends Resource

class_name Celebracao

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#enum Tempo {COMUM, ADVENTO, DE_17_DEZ_A_1_JAN, NATAL, CINZAS, QUARESMA, SEMANA_SANTA_E_OITAVA_PASCOA, PASCOA}
#enum Tipo {COMUM, TEMPO, MEMORIA_FACULTATIVA, MEMORIA, FESTA, SOLENIDADE}
#enum Hora {INVITATORIO, LEITURAS, LAUDES, MEDIA, VESPERAS, COMPLETAS}
#var tipo:int
#var hora:int
#var partes:Array
#
#enum TipoParte {Hino, Salmo}

export(Globais.Hora) var hora
export(Globais.TipoCelebracao) var tipo
export(Globais.Tempo) var tempo
export(Globais.DiaDaSemana) var dia_da_semana
export(int) var mes
export(int) var dia
export(String) var nome
export(Array,Resource) var partes
#export(Array,Resource) var antifonas

#class Parte:
#	var caminho:String # Se houver salmo/hino no próprio/tempo ou comum
#	var antifona:Array # Array de caminhos para antífonas alternativas

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func lista_opcoes():
	var resultado = []
	for p in range(len(partes)):
		var parte = {}
		if typeof(partes[p].cantos) == TYPE_ARRAY:
			parte['cantos'] = []
			for c in range(len(partes[p].cantos)):
				parte['cantos'].append([c, partes[p].cantos[c].nome])
		if typeof(partes[p].antifonas) == TYPE_ARRAY:
			parte['antifonas'] = []
			for c in range(len(partes[p].antifonas)):
				parte['antifonas'].append([c, partes[p].antifonas[c].nome])
		resultado.append(parte)
	return resultado

#func parte(n, opcao_canto=0, opcao_antifona=0) -> Parte:
#	var p = Parte.new()
#	if typeof(partes[n].cantos) == TYPE_ARRAY:
#		p.cantos = partes[n].cantos[opcao_canto]
#	else:
#		p.cantos = partes[n].cantos
#	if typeof(partes[n].antifonas) == TYPE_ARRAY:
#		p.antifonas = partes[n].antifonas[opcao_antifona]
#	else:
#		p.antifonas = partes[n].antifonas
#	return p

func busca_parte(tipo_parte:int):
	var resultado = []
	for p in partes:
		if p.tipo == tipo_parte:
			resultado.append(p)
	return resultado

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
