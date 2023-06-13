#!/bin/bash

source /home/ubuntu/miniconda3/bin/activate tethys

products=("eqm" "scal")
date_download=$(date +%Y%m%d)
type_vars=("precipitation" "temperature" "ensemble")
thredds_eta_path='/home/ubuntu/data/thredds/public/ETA22'
ncml_eta_path='/home/ubuntu/scripts/thredds/ncml_files/ETA22'
python_script_base_path='/home/ubuntu/scripts/thredds/eta'
file_prefixes=("pp")
log_file="/var/log/data_scripts/eta_data.log"
lastest_name="latest"
for product in ${products[@]}; do
    for type_var in ${type_vars[@]}; do
        if [[ "$type_var" == "precipitation" ]]; then
            file_prefixes=("pp")
        elif [[ "$type_var" == "temperature" ]]; then
            file_prefixes=("tn" "tx")
        elif [[ "$type_var" == "ensemble" ]]; then
            file_prefixes=("ens")
        fi
        for file_prefix in ${file_prefixes[@]}; do
            if [[ "$type_var" == "ensemble" ]]; then
                file_name="pp_${date_download}_${file_prefix}_${product}"
                lastest_name="latest_pp_${file_prefix}_${product}"
            else
                file_name=${file_prefix}_${date_download}_${product}
                lastest_name="latest_${file_prefix}_${product}"
            fi
            path_to_file="${thredds_eta_path}/${product}/determinista/${type_var}/${file_name}.nc"
            path_to_ncml="${ncml_eta_path}/${product}/${file_name}.ncml"
            path_to_updated_file="${thredds_eta_path}/${product}/determinista/${type_var}/corrected/${file_name}_corrected.nc"

            # execute the python script correct_ncml_climate_change.py
            echo "Fixing ${product} ${type_var} ${file_prefix} ETA22 data"
            python ${python_script_base_path}/correct_ncml_climate_change.py $path_to_file $path_to_ncml


            sed -i "/'z'/s//'time'/" $path_to_ncml
            sed -i '/"z"/s//"time"/' $path_to_ncml
            sed -i '/"z"/s//"time"/' $path_to_ncml
            sed -i '3,9d' $path_to_ncml
            sed -i 's:\(<variable name="time".*\)\(>\):\1 orgName="z" \2:' $path_to_ncml

            source /home/ubuntu/miniconda3/bin/activate tethys

            # execute the python script generate_climate_change.py
            python ${python_script_base_path}/generate_climate_change.py $path_to_file $path_to_ncml $path_to_updated_file
            sleep 5
            #clean all the files in the following dirs
            echo "deleted ${path_to_file}"
            rm ${path_to_file}
            echo "deleted ${path_to_ncml}"
            rm ${path_to_ncml}

            #Only keep the three files in the corrected folder
            data_directory=${thredds_eta_path}/${product}/determinista/${type_var}/corrected
            if [[ $(find "$data_directory" -mtime +4 -type f) ]]; then
                find "$data_directory" -mtime +4 -type f -delete -printf "FILE: %f\n" | sed 's/^/FILE: /'
                succesful_date="Deleting Job on date $(date +%Y%m%d) deleted the following files"
                echo "${succesful_date}"
            fi

            #Make a copy called latest
            cp $path_to_updated_file $thredds_eta_path/$product/determinista/$type_var/corrected/${lastest_name}.nc
            echo -e "latest file for ${product} ${type_var} ${file_prefix} ETA22 data created with name: ${lastest_name}.nc"

        done
    done
done


