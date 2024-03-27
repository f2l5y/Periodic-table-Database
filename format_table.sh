  1 #!bin/bash
  2 
  3 PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
  4 
  5 #Capitalize first letter  of the Symbol column
  6 # echo "$($PSQL "SELECT symbol FROM elements;")" | while IFS="" read NAME
  7 # do
  8 #       echo $($PSQL "UPDATE elements SET symbol='$(echo "${NAME^}")' WHERE symbol='$    NAME';")
  9 # done
 10 
 11 
 12 #remove trailing zeros from atomic mass
 13 
 14 echo "$($PSQL "SELECT atomic_mass  FROM properties;")" | while IFS="" read MASS
 15 do
 16   echo "$($PSQL "UPDATE properties SET atomic_mass="$( echo $MASS | sed -E 's/([1-9]+    )0+$/\1/g')" WHERE atomic_mass='$MASS';")"
 17 
 18 done
~                       
