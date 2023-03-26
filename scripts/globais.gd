extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const VALOR_BASE:int = 480 # colcheia
var config = ConfigFile
var semibreve:int = 8*VALOR_BASE
var breve:int = 2 * semibreve
var valor_breve:int = 8 setget _set_valor_breve, _get_valor_breve
var pausa_inicial:int = VALOR_BASE * 2
var valor_pausa_inicial:float = pausa_inicial / VALOR_BASE / 2 setget _set_valor_pausa, _get_valor_pausa
var tempo:int = 60 setget _set_tempo
var tempo_colcheia:int = tempo * 2
var medir_sempre:bool = false
var repetir_antifona:bool = true
var cantar_refroes:bool = true
var instrumento_melodia:int = 74
var instrumento_harmonia:int = 1
var velocidade_harmonia:int = 40
var volume:int = -10
enum Tipos {MEDIDO, RECITADO}
enum TipoPartes {Hino, Salmo}
enum Tempo {
	COMUM,
	ADVENTO,
	DE_17_A_24_DEZ,
	OITAVA_NATAL,
	NATAL,
	CINZAS,
	QUARESMA,
	SEMANA_SANTA,
	OITAVA_PASCOA,
	PASCOA,
	NAO_SE_APLICA
}
enum TipoCelebracao {
	ORDINARIO,
	COMUM,
	TEMPO,
	MEMORIA_FACULTATIVA,
	MEMORIA,
	FESTA,
	SOLENIDADE
}
enum LugarParte {
	VERSICULO_INTRODUTORIO,
	HINO,
	SALMO,
	RESPONSORIO_SALMO,
	RESPONSORIO_LEIT1,
	RESPONSORIO_LEIT2,
	CANTICO_EVANGELICO,
	TE_DEUM,
	DESPEDIDA,
	ANTIFONAS_NOSSA_SENHORA
}
enum Hora {
	I_VESPERAS,
	I_COMPLETAS,
	INVITATORIO,
	LEITURAS,
	LAUDES,
	MEDIA,
	VESPERAS,
	COMPLETAS
}
enum DiaDaSemana {
	DOMINGO,
	SEGUNDA,
	TERCA,
	QUARTA,
	QUINTA,
	SEXTA,
	SABADO
}
enum Mes {
	NAO_SE_APLICA,
	JANEIRO,
	FEVEREIRO,
	MARCO,
	ABRIL,
	MAIO,
	JUNHO,
	JULHO,
	AGOSTO,
	SETEMBRO,
	OUTUBRO,
	NOVEMBRO,
	DEZEMBRO
}

func salvar():
	config.set_value('preferencias', 'tempo', tempo)
	config.set_value('preferencias', 'valor_breve', valor_breve)
	config.set_value('preferencias', 'medir_sempre', medir_sempre)
	config.set_value('preferencias', 'valor_pausa_inicial', valor_pausa_inicial)
	config.set_value('preferencias', 'repetir_antifona', repetir_antifona)
	config.set_value('preferencias', 'instrumento_melodia', instrumento_melodia)
	config.set_value('preferencias', 'instrumento_harmonia', instrumento_harmonia)
	config.set_value('preferencias', 'velocidade_harmonia', velocidade_harmonia)
	config.set_value('preferencias', 'volume', volume)
	var erro = config.save('user://liturgiadashoras_acompanhamentomusical.ini')
	if erro:
		print('Erro ao salvar configurações.')

# Called when the node enters the scene tree for the first time.
func _ready():
	config = ConfigFile.new()
	var erro = config.load('user://liturgiadashoras_acompanhamentomusical.ini')
	if !erro:
		print('Carregando configurações:')
		_set_tempo(config.get_value('preferencias', 'tempo', 60))
		print('Tempo: ', tempo)
		_set_valor_breve(config.get_value('preferencias', 'valor_breve', 8))
		print('Valor da breve: ', valor_breve)
		medir_sempre = config.get_value('preferencias', 'medir_sempre', false)
		print('Sempre medir a música: ', medir_sempre)
		_set_valor_pausa(config.get_value('preferencias', 'valor_pausa_inicial', 1))
		print('Pausa inicial na recitação medida: ', valor_pausa_inicial)
		repetir_antifona = config.get_value('preferencias', 'repetir_antifona', true)
		print('Repetir antífona: ', repetir_antifona)
		instrumento_melodia = config.get_value('preferencias', 'instrumento_melodia', 74)
		print('Instrumento melodia: ', instrumento_melodia)
		instrumento_harmonia = config.get_value('preferencias', 'instrumento_harmonia', 1)
		print('Instrumento harmonia: ', instrumento_harmonia)
		velocidade_harmonia = config.get_value('preferencias', 'velocidade_harmonia', 40)
		print('Velocidade MIDI da harmonia: ', velocidade_harmonia)
		volume = config.get_value('preferencias', 'volume', -10)
		print('Volume geral: ', volume)
	else:
		print('Erro ao carregar configurações do arquivo.')

func _set_valor_breve(valor:int):
	valor_breve = valor
	breve = valor * VALOR_BASE * 2
	
func _get_valor_breve() -> int:
	return breve / VALOR_BASE / 2
	
func _set_valor_pausa(valor:float):
	valor_pausa_inicial = valor
	pausa_inicial = valor * VALOR_BASE * 2
	
func _get_valor_pausa() -> float:
	return float(pausa_inicial) / VALOR_BASE / 2
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _set_tempo(valor:int):
	tempo_colcheia = valor*2
	tempo = valor
