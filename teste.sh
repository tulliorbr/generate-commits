#!/usr/bin/env bash

start_date=$(date '2022-05-01')
end_date=$(date '+%Y-%m-%d')

current_date="$start_date"

# Enquanto a data atual for menor ou igual a end_date...
while [[ "$(date -d "$current_date" '+%Y%m%d')" -le "$(date -d "$end_date" '+%Y%m%d')" ]]; do
    # Converte a data atual para ISO 8601 com horário e fuso, por exemplo: 2025-01-05T12:34:56-03:00
    iso_date=$(date -d "$current_date" '+%Y-%m-%dT%H:%M:%S%z')

    # Cria uma variável com um número aleatório entre 1 e 10
    random_commits=$((RANDOM % 10 + 1))

    for ((i=1; i<=$random_commits; i++)); do
        echo "$iso_date Commit $i" >> README.md
        git commit -a -m "Commit $i" --date="$iso_date"
        sleep 1.0
    done

    # Avança 1 dia
    current_date=$(date -d "$current_date + 1 day" '+%Y-%m-%d')
done
