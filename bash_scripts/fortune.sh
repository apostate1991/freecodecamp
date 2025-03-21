#! /bin/bash
#Program to tell a persons fortune
echo -e "\n~~ Fortune Teller ~~\n"
RESPONSES=("Yes" "No" "Maybe" "Outlook good" "Don't count on it" "Ask again later")
N=$(( $RANDOM % 6 ))

GET_FORTUNE() {

if [[ ! $1 ]] 
then 
echo "Ask a yes or no question:"
else
echo Try again. Make sure it ends with a question mark:
fi
}

GET_FORTUNE

until [[ $QUESTION =~ \?$ ]]
do
  read QUESTION
if [[ ! $QUESTION =~ \?$ ]]
then  GET_FORTUNE again
fi
done

echo -e "\n${RESPONSES[$N]}"