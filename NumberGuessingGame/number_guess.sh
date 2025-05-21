#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#ASk user to enter his username
#username should not be longer than 22 chars 
#get user

get_user() {
  echo "Enter your username:"
  read USERNAME
  if [[ -z $USERNAME ]]
  then 
    echo "Empty name"
  elif [[ ${#USERNAME} -gt 22 ]]
  then
    echo "The name is greater than 22 characters, please use less characters in your name"
  fi	

  USER_ID=$($PSQL "SELECT username_id FROM users WHERE username ='$USERNAME'") 
  if [[ -z $USER_ID ]]
  then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    INSERT_USERNAME_TO_DB=$($PSQL "INSERT INTO users(username) values('$USERNAME')";)
    USER_ID=$($PSQL "SELECT username_id FROM users WHERE username ='$USERNAME'")
  else
    games_played=$($PSQL "SELECT COUNT(game_id) FROM games WHERE username_id = $USER_ID")
    best_game=$($PSQL "SELECT MIN(guesses) FROM games WHERE username_id = $USER_ID")
    #echo "$USER_INFO" | while read USER_ID BAR USERNAME
    echo "Welcome back, $USERNAME! You have played $games_played games, and your best game took $best_game guesses."
  fi
}

#The next line printed should be Guess the secret number between 1 and 1000:
#Until they guess the secret number, it should print It's lower than that, guess again:
# if the previous input was higher than the secret number, and It's higher than that, guess again:
#If anything other than an integer is input as a guess, it should print That is not an integer, guess again:
#When the secret number is guessed, your script should print
#You guessed it in <number_of_guesses> tries. The secret number was <secret_number>. Nice job! and finish running

#main game logic
play_game() {

SECRET_NUMBER=$(( $RANDOM % 1000 + 1 ))
attempts=0

echo "Guess the secret number between 1 and 1000:"
 while true; do
        read INPUT
        if ! [[ "$INPUT" =~ ^[0-9]+$ ]]
		then
            echo "That is not an integer, guess again:"
            continue
        fi
        ((attempts++))
        if [[ $INPUT -lt $SECRET_NUMBER ]]
		then
            echo "It's higher than that, guess again:"
        elif [[ $INPUT -gt $SECRET_NUMBER ]]
		then
            echo "It's lower than that, guess again:"
        else
            echo "You guessed it in $attempts tries. The secret number was $SECRET_NUMBER. Nice job!"
            INSERT_GAME_RESULT_TO_DB=$($PSQL "INSERT INTO games(username_id, secret_number, guesses) VALUES($USER_ID, $SECRET_NUMBER, $attempts)")
            break
        fi
    done

}

get_user
play_game