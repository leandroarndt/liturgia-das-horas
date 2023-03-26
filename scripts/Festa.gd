extends Tree


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var raiz:TreeItem
var indices:Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var colecao = load("res://assets/Salterio/Colecoes/tudo.tres")
	var meses = {
		0: 'Festas móveis',
		1: 'Janeiro',
		2: 'Fevereiro',
		3: 'Março',
		4: 'Abril',
		5: 'Maio',
		6: 'Junho',
		7: 'Julho',
		8: 'Agosto',
		9: 'Setembro',
		10: 'Outubro',
		11: 'Novembro',
		12: 'Dezembro',
	}
	var itens = {}
	raiz = create_item()
	raiz.set_text(0, 'Festas litúrgicas')
	raiz.set_selectable(0, false)
	for mes in meses.keys():
		itens[mes] = create_item(raiz)
		itens[mes].set_text(0, meses[mes])
		itens[mes].collapsed = true
		itens[mes].set_selectable(0, false)
		itens[mes].set_metadata(0, mes)
	for festa in colecao.listar_festas():
		var item = create_item(itens[festa.mes])
		item.set_text = festa.nome
		item.set_selectable(0, true)
		item.set_metadata = festa
#	var festas_moveis = create_item(raiz)
#	festas_moveis.set_text(0, 'Festas móveis')
#	festas_moveis.collapsed = true
#	festas_moveis.set_selectable(0, false)
#	festas_moveis.set_metadata(0, 0)
#	var n:int = 0
#	for festa in ['Batismo do Senhor', 'Quarta-feira de Cinzas', 'Páscoa']:
#		var item = create_item(festas_moveis)
#		item.set_text(0, festa)
#		item.set_metadata(0, load('res://assets/Salterio/Quaresma/Completas - quaresma.tres'))
#		print(item.get_metadata(0))
#		n += 1
#	var janeiro = create_item(raiz)
#	janeiro.set_text(0, 'Janeiro')
#	janeiro.set_selectable(0, false)
#	janeiro.set_metadata(0, 1)
#	var fevereiro = create_item(raiz)
#	fevereiro.set_text(0, 'Fevereiro')
#	fevereiro.set_selectable(0, false)
#	fevereiro.set_metadata(0, 2)
#	var marco = create_item(raiz)
#	marco.set_text(0, 'Março')
#	marco.set_selectable(0, false)
#	marco.set_metadata(0, 3)
#	var abril = create_item(raiz)
#	abril.set_text(0, 'Abril')
#	abril.set_selectable(0, false)
#	abril.set_metadata(0, 4)
#	var maio = create_item(raiz)
#	maio.set_text(0, 'Maio')
#	maio.set_selectable(0, false)
#	maio.set_metadata(0, 5)
#	var junho = create_item(raiz)
#	junho.set_text(0, 'Junho')
#	junho.set_selectable(0, false)
#	var julho = create_item(raiz)
#	julho.set_text(0, 'Julho')
#	julho.set_selectable(0, false)
#	var agosto = create_item(raiz)
#	agosto.set_text(0, 'Agosto')
#	agosto.set_selectable(0, false)
#	var setembro = create_item(raiz)
#	setembro.set_text(0, 'Setembro')
#	setembro.set_selectable(0, false)
#	var outubro = create_item(raiz)
#	outubro.set_text(0, 'Outubro')
#	outubro.set_selectable(0, false)
#	var novembro = create_item(raiz)
#	novembro.set_text(0, 'Novembro')
#	novembro.set_selectable(0, false)
#	var dezembro = create_item(raiz)
#	dezembro.set_text(0, 'Dezembro')
#	dezembro.set_selectable(0, false)
#	print(get_selected())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
