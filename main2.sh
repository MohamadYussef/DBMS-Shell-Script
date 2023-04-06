update_table() {
    read -p "Enter Table Name : " table_name
    if [ $(ls | grep -x $table_name) ]; then
        read -p "Enter Coloumn Name : " col_name
        field_num= $(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$col_name'") print i}}}' $table_name)
        fields=($(head -1 $tablename | sed -n 's/:/ /gp'))
        num_of_fields=${#fields[@]}
        match_found=""
        for field in ${fields[@]}; do
            if [ $field_name = $field ]; then
                match_found=true
            fi
        done
        if [ $match_found ]; then
            read -p "Enter Primary key: " pk
            if [ $(cut -d : -f 1 $table_name | sed -n '3,$p' | grep $pk) ]; then
                read -p "Insert new value: " new_value
                awk
            else
                echo "Primary key not found"
            fi
        else
            echo "Field Doesn't Exist"
        fi
    else
        echo "Table Doesn't Exist"
    fi
}
