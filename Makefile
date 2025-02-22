# Formato geral de um Makefile
#
# alvo: pre-requisitos1 pre-requisitos2 ...
#	comandos que usam os pre-requisitos para gerar o alvo

all: paper/paper.pdf resultados/numero_de_dados.txt
	# n precisa de comandos
	
clean: # n precisa de pré requisitos
	rm -r -f resultados dados figuras paper/paper.pdf

paper/paper.pdf: paper/paper.tex figuras/variacao_temeperatura.png
	tectonic -X compile paper/paper.tex

resultados/numero_de_dados.txt: dados/temperature-data.zip
	mkdir -p resultados
	ls dados/temperatura/*.csv | wc -l > resultados/numero_de_dados.txt

dados/temperature-data.zip: code/baixa_dados.py
	python code/baixa_dados.py dados

resultados/variacao_temperatura.csv: dados/temperature-data.zip code/variacao_temperatura_todos.sh
	mkdir -p resultados
	bash code/variacao_temperatura_todos.sh > resultados/variacao_temperatura.csv

figuras/variacao_temeperatura.png: code/plota_dados.py resultados/variacao_temperatura.csv
	mkdir -p figuras
	python code/plota_dados.py resultados/variacao_temperatura.csv figuras/variacao_temeperatura.png