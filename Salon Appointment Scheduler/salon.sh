#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~ Welcome to our Salon ~~\n"

echo "How may I help you?"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  SERVICES=$($PSQL "SELECT * FROM services ORDER BY service_id")
  if [[ -z $SERVICES ]]
    then
    echo "Sorry, we don't have this service available right now"
    else
    echo -e "These are our services:"
    echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
      echo "$SERVICE_ID) $SERVICE_NAME"
    done
    
    echo -e "\n Please pick one of the services above by it's number:"
    read SERVICE_ID_SELECTED

      if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
      then
        MAIN_MENU "That is not a number."
      else
        SERVICE_TO_SCHEDULE=$($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID_SELECTED")
        if [[ -z $SERVICE_TO_SCHEDULE ]]
        then
          MAIN_MENU "I did not find that service. Please, try again."
        else
        echo -e "\n What is your phone number?"
        read CUSTOMER_PHONE
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
          if [[ -z $CUSTOMER_NAME ]]
          then
            echo -e "\nWhat is your name?"
            read CUSTOMER_NAME
            REGISTER_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
          fi
          SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_TO_SCHEDULE")
          echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
          read SERVICE_TIME
          CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
          if [[ $SERVICE_TIME ]]
          then
            REGISTER_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_TO_SCHEDULE, '$SERVICE_TIME')")
            if [[ $REGISTER_APPOINTMENT ]]
            then
              echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
            fi
          fi
        fi
      fi  
  fi
}

MAIN_MENU
