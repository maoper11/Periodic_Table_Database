#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# is there any arguments?
if [ -z "$1" ]
then
  echo "Please provide an element as an argument."
else
  # if input is not a number
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then    
    # Search by symbol or name
    QUERY_ELEMENT=$($PSQL "SELECT * FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING (type_id) WHERE symbol = '$1' OR name = '$1';")
  else 
    # Search by atomic_number
    QUERY_ELEMENT=$($PSQL "SELECT * FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING (type_id) WHERE atomic_number = $1;")
  fi

  if [[ -z $QUERY_ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$QUERY_ELEMENT" | while read TYPE_ID BAR ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR SYMBOL BAR NAME BAR TYPE
    do
      echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      #echo "$SERVICE_ID) $NAME"
    done

  fi
  

  
fi
