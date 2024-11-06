#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# is there any arguments?
if [ -z "$1" ]
then
  echo "Please provide an element as an argument."
else
  # if input is not a number
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then    
    # Search by symbol or name
    QUERY_ELEMENT=$($PSQL "SELECT * FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol = '$1' OR name = '$1';")
  else 
    # Search by atomic_number
    QUERY_ELEMENT=$($PSQL "SELECT * FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number = $1;")
  fi

  if [[ -z $QUERY_ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "Somenthing Found"
  fi
  
#echo -e "The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
  
fi
