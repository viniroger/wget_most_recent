#!/bin/bash
## Script para baixar arquivo mais recente

base_url="https://www.site.org.br/publicacao"

for n in {1..5}; do
	# Montar url do arquivo
	ano=$(date --date="$n days ago" +%Y)
	mes_digito=$(date --date="$n days ago" +%m)
	mes_nome=$(date --date="$n days ago" +%B)
	mes=$mes_digito'_'$mes_nome
	dia=$(date --date="$n days ago" +%d-%m-%y)
	data_link=$base_url'/'$ano'/'$mes'/'$dia'.pdf'
	
	# Verificar se link está ativo
	wget -q --spider $data_link
	status=`echo $?`
	echo "Status de" $data_link ":" $status
	
	# Se tiver o arquivo, baixar e sair do programa
	if [ "$status" -eq "0" ]; then
		wget -nv -P temp $data_link
		break
	fi
done
