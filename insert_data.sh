#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

cat properties.txt | while IFS="," read -r atomic_number type atomic_mass melting_p boiling_p; do
    # Trim leading and trailing whitespace from 'type' field
    type=$(echo "$type" | tr -d '[:space:]')

    if [[ "$type" == "metal" ]]; then
        echo "$($PSQL "INSERT INTO properties(atomic_number,type,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) VALUES('$atomic_number','$type', '$atomic_mass', '$melting_p', '$boiling_p',1);")"
    elif [[ "$type" == "nonmetal" ]]; then
        echo "$($PSQL "INSERT INTO properties(atomic_number,type,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) VALUES('$atomic_number','$type', '$atomic_mass', '$melting_p', '$boiling_p',3);")"
    elif [[ "$type" == "metalloid" ]]; then
        echo "$($PSQL "INSERT INTO properties(atomic_number,type,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) VALUES('$atomic_number','$type', '$atomic_mass', '$melting_p', '$boiling_p',2);")"
    fi
done           
