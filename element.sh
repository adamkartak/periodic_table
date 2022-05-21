#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.

else
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
      # check if USER_ELEMENT exists
      CHECK_ARG_ELEMENT=$($PSQL "SELECT name FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol = '$1' OR name = '$1';")
      if [[ -z $CHECK_ARG_ELEMENT ]]
      then
        echo "I could not find that element in the database."
      else
        USR_STUFF=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1';")    
        echo "$USR_STUFF" | while read ATOMIC BAR NAME BAR SYMBOL BAR TYPE BAR MASS BAR MELT BAR BOIL
        # statement
        do
        echo "The element with atomic number $ATOMIC is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
        done
      fi
        # if doesn't exist, print statement > start over
      # prepare vars for statement
      # statement
  else
      CHECK_ARG_ELEMENT_NUM=$($PSQL "SELECT name FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number = '$1';")
      if [[ -z $CHECK_ARG_ELEMENT_NUM ]]
      then
        echo "I could not find that element in the database."
      else
        USR_STUFF=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number = '$1';")    
        echo "$USR_STUFF" | while read ATOMIC BAR NAME BAR SYMBOL BAR TYPE BAR MASS BAR MELT BAR BOIL
        # statement
        do
        echo "The element with atomic number $ATOMIC is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
        done
      fi
  fi
  
fi