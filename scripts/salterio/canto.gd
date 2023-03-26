extends Resource

class_name Canto

export(String) var nome
export(Globais.TipoPartes) var tipo
export(Array,Resource) var estrofes
export(Array,Resource) var refroes
export(Resource) var gloria
#export(String) var caminho

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func montar(antifona:Estrofe=Estrofe.new(), refrao:int=-1):
	var tudo = []
	if antifona.versos:
		tudo.append(antifona)
	for e in estrofes:
		tudo.append(e)
		if refrao >= 0 and Globais.cantar_refroes:
			tudo.append(refroes[refrao])
		#var est = load(caminho+'estrofe-'+String(e)+'.tres')
#		tudo.append(load(resource_path.get_base_dir()+'/'+'estrofe-'+e+'.tres'))
#		if refrao >= 0 and Globais.cantar_refroes:
#			tudo.append(load(resource_path.get_base_dir()+'/'+'refrao-'+refroes[refrao]+'.tres'))
		elif Globais.repetir_antifona:
			if antifona.versos:
				tudo.append(antifona)
	var checagem = Directory.new()
#	if checagem.file_exists(resource_path.get_base_dir()+'/'+'gloria.tres'):
#		tudo.append(load(resource_path.get_base_dir()+'/'+'gloria.tres'))
	if gloria:
		tudo.append(gloria)
	if antifona.versos:
		tudo.append(antifona)
	return tudo
	
func lista_refroes():
	var lista = []
	for r in range(len(refroes)):
		lista.append([r, refroes[r].nome])
	return lista

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
