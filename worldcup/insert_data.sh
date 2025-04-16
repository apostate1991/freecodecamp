#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE games, teams RESTART IDENTITY;")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $WINNER != winner ]]
	then 
#get team_id
	TEAM_ID=$($PSQL "SELECT team_id from teams WHERE name='$WINNER' OR name='$OPPONENT'")
#if not found
		if [[ -z $TEAM_ID ]]
			then 
#insert winner_team
	INSERT_WINNER_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER') ON CONFLICT (name) DO NOTHING RETURNING team_id;")
		if [[ $INSERT_ROUND == "INSERT 0 1" ]]
			then
		echo "Inserted winners into teams(name) : $WINNER"
			else
		echo "Duplicate winners are: $WINNER"
		fi
		fi
fi

if [[ $OPPONENT != opponent ]]
	then
#insert opponent_team
	INSERT_OPPONENT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT') ON CONFLICT (name) DO NOTHING RETURNING team_id;")
		if [[ $INSERT_ROUND == "INSERT 0 1" ]]
			then
	echo "Inserted opponents into teams(name) : $OPPONENT"
		else
	echo "Duplicate opponents are: $OPPONENT"
		fi
fi
done

tail -n +2 games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
#get_new_team_id
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
INSERT_info=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
if [[ $INSERT_info == "INSERT 0 1" ]]
			then
	echo "Inserted : $YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS"
		else
	echo "Failed to insert: $YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS"
		fi
done