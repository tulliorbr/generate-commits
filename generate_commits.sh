#!/usr/bin/env bash

# Data inicial: 1º de maio de 2022
start_date="2022-05-01"
# Data final: hoje
end_date=$(date '+%Y-%m-%d')

current_date="$start_date"

# Enquanto a data atual for menor ou igual a end_date...
while [[ "$(date -d "$current_date" '+%Y%m%d')" -le "$(date -d "$end_date" '+%Y%m%d')" ]]; do
    # Verifica se o dia da semana é de segunda a quinta (1 a 4)
    day_of_week=$(date -d "$current_date" '+%u')
    if [[ "$day_of_week" -ge 1 && "$day_of_week" -le 4 ]]; then
        # Converte a data atual para ISO 8601 com horário e fuso, por exemplo: 2025-01-05T12:34:56-03:00
        iso_date=$(date -d "$current_date" '+%Y-%m-%dT%H:%M:%S%z')

        # Cria uma variável com um número aleatório entre 1 e 3 commits por dia
        random_commits=$((RANDOM % 3 + 1))

        for ((i=1; i<=$random_commits; i++)); do
            # Adiciona uma mensagem de commit ao README.md
            echo "$iso_date Commit $i" >> README.md
            # Faz o commit com a data sobrescrita
            git commit -a -m "Commit $i" --date="$iso_date"
        done
    fi

    # Avança 1 dia
    current_date=$(date -d "$current_date + 1 day" '+%Y-%m-%d')
done
