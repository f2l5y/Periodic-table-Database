#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


FIND_ELEMENT() {
# no argument provided
if [[ ! $1 ]]; then
	echo Please provide an element as an argument.
else

# if a digit
if  [[ $1 =~ ^[0-9]+$ ]]
then
	atomic_number=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number='$1';") 

# if less then three characters (symbol)
elif [[ ${#1} -le 3 ]];then

atomic_number=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';") 

# if a name
else
atomic_number=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';") 
fi


# if not found
if [[ -z $atomic_number ]];then
   echo "I could not find that element in the database."

# if found, start the queries
else

name=$($PSQL "SELECT name FROM elements WHERE atomic_number=$atomic_number;")
symbol=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$atomic_number;")
TYPE=$($PSQL "SELECT type  FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number=$atomic_number;")
melting_point=$($PSQL "SELECT melting_point_celsius  FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number=$atomic_number;")
boiling_point=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number=$atomic_number;")
mass=$($PSQL "SELECT atomic_mass  FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number=$atomic_number;")


echo "The element with atomic number $atomic_number is $name ($symbol). It's a $TYPE, with a mass of $mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
fi
fi
}

# call the function with argument
FIND_ELEMENT $1
