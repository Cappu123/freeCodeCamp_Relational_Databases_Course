# Ask a user to provide an element as an argument.

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Main program
main () {
    # If user inputs an argument
    if [[ $1 ]]
    then
	    QUERY=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types ON properties.type_id = types.type_id WHERE atomic_number::text = '$1' OR symbol = '$1' OR name = '$1'";)

      #If query not found
      if [[ -z $QUERY ]]
      then
        echo "I could not find that element in the database."
      else
      echo "$QUERY" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done

      fi
    else
      # If no argument is passesed
      echo "Please provide an element as an argument."
    fi
}
main "$1"
