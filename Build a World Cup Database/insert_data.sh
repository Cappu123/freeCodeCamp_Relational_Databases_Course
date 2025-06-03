#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE TABLE games, teams")

# INSERT INTO THE teams TABLE

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
# Pass the header row
if [[ $WINNER != "winner" ]]
then
# Get team_id FROM WINNER TEAM
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
# If not found
if [[ -z $WINNER_ID ]]
then
# Add the team
INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
if [[ $INSERT_TEAM == "INSERT 0 1" ]]
then
  echo INSERTED Team: $WINNER
fi
# Re-fetch the team_id
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
fi


#GET TEAM_ID FROM OPPONENT TEAM
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
# If not found
if [[ -z $OPPONENT_ID ]]
then
# Add the new team
INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
# If inserted, get team_id
if [[ $INSERT_TEAM == "INSERT 0 1" ]]
then
  echo Inserted Team: $OPPONENT
fi

#Re-fetch the team_id
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
fi
fi

#INSERT INTO THE games TABLE
INSERT_GAMES=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
if [[ $INSERT_GAMES = "INSERT 0 1" ]]
then
  echo Inserted Game: $YEAR: $WINNER Vs $OPPONENT
fi
done
