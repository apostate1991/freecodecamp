#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment ~~~~~\n"

# Store services with cleaned formatting
LIST_OF_SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id" | sed 's/^ *//;s/ *$//')

MAIN_MENU() {
  if [[ $1 ]]; then 
    echo -e "\n$1"
  else
    echo # Adds a newline if no error message
  fi
  echo "Available services:"
  if [[ -z $LIST_OF_SERVICES ]]; then 
    echo "No services found in database"
  else
    echo "$LIST_OF_SERVICES" | while read SERVICE_ID BAR NAME; do
      echo "$SERVICE_ID) $NAME"
    done
  fi
}

# Main menu loop
while true; do
  MAIN_MENU "$ERROR_MSG"
  ERROR_MSG="" # Resetting error message after showing it
  
  echo -e "\nPlease specify number of required service (or 'e' to exit):"
  read SERVICE_ID_SELECTED
  
  # Check for exit command
  if [[ "$SERVICE_ID_SELECTED" =~ ^[Ee]$ ]]; then
    echo "Goodbye!"
    exit 0
  fi
  
  # Trim whitespace from users input
  SERVICE_ID_SELECTED=$(echo "$SERVICE_ID_SELECTED" | xargs)
  
  # Create array of valid service IDs
  VALID_IDS=()
  while read SERVICE_ID BAR NAME; do
    VALID_IDS+=("$SERVICE_ID")
  done <<< "$LIST_OF_SERVICES"
  
  # Validation logic
  if [[ -z "$SERVICE_ID_SELECTED" ]]; then
    ERROR_MSG="Error: No input provided"
    continue
  elif ! [[ "$SERVICE_ID_SELECTED" =~ ^[0-9]+$ ]]; then
    ERROR_MSG="Error: Please enter a number"
    continue
  elif ! [[ " ${VALID_IDS[@]} " =~ " $SERVICE_ID_SELECTED " ]]; then
    ERROR_MSG="Error: Service $SERVICE_ID_SELECTED doesn't exist"
    continue
  fi
  
  # If we get here, the input is valid
  echo -e "\nYou selected service number: $SERVICE_ID_SELECTED"
  break
done

# Get customer info
echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE  # Fixed variable name (was PHONE_NUMBER)

# Get customer name if exists
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

# If customer doesn't exist
if [[ -z $CUSTOMER_NAME ]]; then
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    # Insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
fi

# Get time for service
echo -e "\nWhat time do you prefer?"
read SERVICE_TIME

# Get customer_id
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

# Insert appointment
INSERT_BOOKING_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")

# Get service name
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")

# Get appointment info 
APPOINTMENT_INFO=$($PSQL "SELECT c.name, s.name, a.time FROM customers c INNER JOIN appointments a ON c.customer_id = a.customer_id INNER JOIN services s ON a.service_id = s.service_id WHERE a.time = '$SERVICE_TIME' AND c.customer_id = '$CUSTOMER_ID'")

# Format appointment info
APPOINTMENT_INFO_FORMATTED=$(echo "$APPOINTMENT_INFO" | sed 's/ | /, /g')

# Send to main menu with appointment confirmation
MAIN_MENU "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."