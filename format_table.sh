#!bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#Capitalize first letter  of the Symbol column
 echo "$($PSQL "SELECT symbol FROM elements;")" | while IFS="" read NAME
 do
  	echo $($PSQL "UPDATE elements SET symbol='$(echo "${NAME^}")' WHERE symbol='$NAME';")
 done


#remove trailing zeros from atomic mass

echo "$($PSQL "SELECT atomic_mass  FROM properties;")" | while IFS="" read MASS
do
  echo "$($PSQL "UPDATE properties SET atomic_mass="$( echo $MASS | sed -E 's/([1-9]+)0+$/\1/g')" WHERE atomic_mass='$MASS';")"

done
