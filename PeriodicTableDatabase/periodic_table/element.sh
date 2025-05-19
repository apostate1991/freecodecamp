#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#If you run ./element.sh 1, ./element.sh H, or ./element.sh Hydrogen,
# it should output only The element with atomic number 1 is Hydrogen (H).
# It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

#If you run ./element.sh script with another element as input,
#you should get the same output but with information associated with the given element.

#If the argument input to your element.sh script doesn't exist
#as an atomic_number, symbol, or name in the database, the only output should be
#I could not find that element in the database.

#It should output for example only:
#The element with atomic number 1 is Hydrogen (H).
#It's a nonmetal, with a mass of 1.008 amu.
#Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
exit
fi

INPUT="$1"

#Aknowledge if it's numeric input or not
if [[ "$INPUT" =~ ^[0-9]+$ ]]; 
then 
# Numeric search (using atomic_number)
PROPERTIES_AND_ELEMENTS=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type from elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$INPUT ORDER BY atomic_number";)
  if [[ -z $PROPERTIES_AND_ELEMENTS ]]
  then 
  echo "I could not find that element in the database."
  else
echo "$PROPERTIES_AND_ELEMENTS" | while read ATOMIC_NUM BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELT BAR BOIL BAR TYPE
do
echo -e "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
done
fi

else
# Text search (using symbol or name)
PROPERTIES_AND_ELEMENTS=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type from elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$1' OR symbol='$1' ORDER BY atomic_number";)
  if [[ -z $PROPERTIES_AND_ELEMENTS ]]
  then 
  echo "I could not find that element in the database."
  else
echo "$PROPERTIES_AND_ELEMENTS" | while read ATOMIC_NUM BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELT BAR BOIL BAR TYPE
do
echo -e "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
done

fi
fi