#!/bin/bash

main_menu() {
    PS3="choose an option in the Database Engine: "
    select choise in "Create Database" "List Databases" "Connect To Databases" "Drop Database" "exit"; do
        case $choise in
        "Create Database") create_DB ;;
        "List Databases") ls -lF ./DB | grep / ;;
        "Connect To Databases") echo co ;;
        "Drop Database") drop_DB ;;
        "exit") exit ;;
        *) echo "Invalid choise" ;;
        esac
    done
}
create_DB() {
    read -p "Enter the name of the Database that will be created: " DB_name
    if [ -e ./DB/"$DB_name" ]; then
        echo "sorry that Database name exist"
        # create_DB
    else
        if [[ "$DB_name" =~ ^[a-z]+[1-9]+ ]]; then
            mkdir ./DB/$DB_name
            echo "The $DB_name database was created successfully"
        else
            echo "invaled name for Database"
        fi
    fi
}

drop_DB() {
    ls -F ./DB/ | grep /
    read -p "Enter the Database you want to remove: " DB_drop
    if [[ $(find ./DB -name $DB_drop) ]]; then
        rm -r ./DB/$DB_drop
        echo "The $DB_drop is removed successfully"
    else
        echo "$DB_drop Database not exist"
    fi
}

main_menu
