#!/bin/bash

main_menu() {
    PS3='>'
    echo "Choose an action: "
    select choice in "Create Database" "List Databases" "Connect To Database" "Drop Database" "exit"; do
        case $choice in
        "Create Database")
            clear
            create_db
            echo -e "\nPress Enter to view menu"
            ;;
        "List Databases")
            clear
            echo -e "Available Databases:\n$(ls -1 ./db)"
            echo -e "\nPress Enter to view menu"
            ;; # ls -F ./db | grep / | sed -n 's/\///gp' ;;
        "Connect To Database")
            clear
            connect_db
            ;;
        "Drop Database")
            clear
            drop_db
            echo -e "\nPress Enter to view menu"
            ;;
        "exit") exit ;;
        *) echo "Invalid choice" ;;
        esac
    done
}
create_db() {
    read -p "Enter the name of the Database that will be created: " db_name
    if [ -e ./db/"$db_name" ]; then
        echo "Database name already exist"

    else
        if [[ "$db_name" =~ ^[a-zA-Z]+[a-zA-Z1-9_]+ ]]; then
            mkdir ./db/$db_name
            echo "The $db_name database was created successfully"
        else
            echo "Invalid name"
        fi
    fi
}

drop_db() {
    echo -e "Available Databases: \n$(ls -1 ./db)"
    read -p "Enter the Database you want to remove: " db_drop
    if [[ $(find ./db -name $db_drop) ]]; then
        rm -r ./db/$db_drop
        echo "The $db_drop is removed successfully"
    else
        echo "$db_drop Database not exist"
    fi
}

# drop_db2() {
#     PS3="Choose a database to drop to:  "
#     echo -e "Available Databases:"
#     select db_name in $(ls ./db); do

#     done

# }

init() {
    if ! [ -d ./db/ ]; then
        mkdir ./db/
    fi
}

connect_db() {

    PS3="Select a Database to connect to: "
    echo -e "Available Databases:"
    select db_name in $(ls ./db); do
        if [ $db_name ]; then
            cd ./db/$db_name
            PS3="$(pwd | awk -F "/" '{print $NF}') >"
            clear
            db_actions
        else
            echo "db not exist"
            connect_db

        fi

    done

}

db_actions() {
    echo "Choose an action: "
    select db_action in "Create table" "Drop table" "Insert table" "Select table" "Delete Table" "List table" "Update table" "Return to the main menu"; do
        case $db_action in
        "Create table") create_table ;;
        "Drop table") echo "function not added yet" ;;
        "Insert table") echo "function not added yet" ;;
        "Select table") echo "function not added yet" ;;
        "Delete Table") echo "function not added yet" ;;
        "List Table") echo "function not added yet" ;;
        "Update Table") echo "function not added yet" ;;
        "Return to the main menu")
            cd ../..
            clear
            main_menu
            ;;
        *) echo "Invalid choice" ;;
        esac
    done
}

create_table() {
    read -p "Enter the table name: " t_name
    if [ -e ./$t_name ]; then
        echo "Table already exist"
        create_table
    else
        if [[ "$db_name" =~ ^[a-zA-Z]+[a-zA-Z1-9_]+ ]]; then
            touch ./$t_name
            read -p "Enter the number of fields: " fields_num
            read -p "Enter Primary key: " pk
            echo -n ${pk}: >>$t_name
            index=1
            while [ $index -lt $fields_num ]; do
                read -p "Enter name for field $index: " field_name
                echo -n ${field_name}: >>$t_name
                let index++
            done
            index=1
            read -p "Enter Primary key type: " pk_t
            echo -en "\n${pk_t}": >>$t_name
            while [ $index -lt $fields_num ]; do
                read -p "Enter type for field $index: " field_type
                echo -n ${field_type}: >>$t_name
                let index++
            done

        else
            echo "Invalid name"
            create_table
        fi
    fi
}
init
main_menu
