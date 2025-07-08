#!/bin/bash

# Variables
RANDOM_NUMBER=$(((RANDOM % 1000) + 1))
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Main Program

main () {
# Ask user to provide a username

echo "Enter your username:"
read USERNAME

# Check if username already present in the db
CHECK_USER=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME';")
CHECK_USERNAME=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME';")
CHECK_USERSTAT=$($PSQL "SELECT COUNT(game_id), MIN(guesses) FROM users JOIN games ON users.user_id = games.user_id WHERE username = '$USERNAME' GROUP BY username";)

# Retreive user's STAT
IFS="|" read TOTAL_GAMES MIN_GUESSES <<< "$CHECK_USERSTAT"

# If username not found, add a user record into the dbGuess the secret number between 1 and 1000:
if [[ -z $CHECK_USERNAME ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  # Record the new user info into the db
  INSERTED_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  # Retreive user id
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
else
  USER_ID=$CHECK_USER
  echo "Welcome back, $USERNAME! You have played $TOTAL_GAMES games, and your best game took $MIN_GUESSES guesses."
fi

  # Proceed with the game
  echo "Guess the secret number between 1 and 1000:"
  while read NUMBER_GUESS
  do
  # Validate Integer
  if [[ ! $NUMBER_GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    continue
  fi
  GUESS=$NUMBER_GUESS
  ((GUESS_COUNT++))

  if (( $NUMBER_GUESS < $RANDOM_NUMBER ))
  then
    echo "It's higher than that, guess again:"
  elif (( $NUMBER_GUESS > $RANDOM_NUMBER ))
  then
    echo "It's lower than that, guess again:"
  else 
    echo "You guessed it in $GUESS_COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"

  # Add user's game stat
  USER_GAME_STAT=$($PSQL "INSERT INTO games(user_id, guesses) VALUES($USER_ID, $GUESS_COUNT);")
  break
  fi
  done
}
main
