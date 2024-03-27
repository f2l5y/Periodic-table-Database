  1 #!/bin/bash
  2 
  3 PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"
  4 
  5 cat properties.txt | while IFS="," read -r atomic_number type atomic_mass melting_p boiling_p; do
  6     # Trim leading and trailing whitespace from 'type' field
  7     type=$(echo "$type" | tr -d '[:space:]')
  8 
  9     if [[ "$type" == "metal" ]]; then
 10         echo "$($PSQL "INSERT INTO properties(atomic_number,type,atomic_mass,melting_point_celsius,boili    ng_point_celsius) VALUES('$atomic_number',$type, $atomic_mass, $melting_p, $boiling_p,1);")"
 11     elif [[ "$type" == "nonmetal" ]]; then
 12         echo "$($PSQL "INSERT INTO properties(atomic_number,type,atomic_mass,melting_point_celsius,boili    ng_point_celsius) VALUES('$atomic_number',$type, $atomic_mass, $melting_p, $boiling_p,3);")"
 13     elif [[ "$type" == "metalloid" ]]; then
 14         echo "$($PSQL "INSERT INTO properties(atomic_number,type,atomic_mass,melting_point_celsius,boili    ng_point_celsius) VALUES('$atomic_number',$type, $atomic_mass, $melting_p, $boiling_p,2);")"
 15     fi
 16 done
~                  
