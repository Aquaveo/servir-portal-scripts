#!/bin/bash

source /home/ubuntu/miniconda3/bin/activate tethys

products=("eqm" "scal")
date_download=$(date +%Y%m%d)
type_vars=("precipitation","temperature","ensemble")
thredds_eta_path='/home/ubuntu/data/thredds/public/ETA22'
ncml_eta_path='/home/ubuntu/scripts/thredds/ncml_files/ETA22'
file_prefixes=("pp")

for product in ${products[@]}; do
    for type_var in ${type_vars[@]}; do
        if [[ "$type_vars" == "precipitation" ]]
            file_prefixes=("pp")
        then        

        elif [[ "$type_vars" == "temperature" ]]
            file_prefixes=("tn","tx")
        then

        elif [[ "$type_vars" == "ensemble" ]]
            file_prefixes=("ens")
        then

        fi
        for file_prefix in ${file_prefixes[@]}; do
            path_to_file="${thredds_eta_path}/${product}/determinista/${type_var}/${file_prex}_${date_download}_${product}.nc"
            path_to_ncml="${ncml_eta_path}/${product}/${file_prex}_${date_download}_${product}.ncml"
            path_to_updated_file="${thredds_eta_path}/${product}/determinista/${type_var}/corrected/${file_prex}_${date_download}_${product}_corrected.nc"
            path_to_ncml2="${ncml_eta_path}/${product}/${file_prex}_${date_download}_${product}2.ncml"

            # execute the python script correct_ncml_climate_change.py
            python /home/ubuntu/scripts/thredds/eta/correct_ncml_climate_change.py $path_to_file $path_to_ncml

            echo "Fixing ${product} ${type_var} ${file_prefix} ETA22 data"

            sed -i "/'z'/s//'time'/" $path_to_ncml
            sed -i '/"z"/s//"time"/' $path_to_ncml
            sed -i '/"z"/s//"time"/' $path_to_ncml
            sed -i '3,9d' $path_to_ncml
            sed -i 's:\(<variable name="time".*\)\(>\):\1 orgName="z" \2:' $path_to_ncml

            source /home/ubuntu/miniconda3/bin/activate tethys

            # execute the python script generate_climate_change.py
            python /home/ubuntu/scripts/thredds/eta/generate_climate_change.py $path_to_file $path_to_ncml $path_to_updated_file         
        done
    done
done


# path_to_file_eqm="/home/ubuntu/data/thredds/public/pronostico_precipitacion/ETA22/eqm/pp_$(date +%Y%m%d)_ens_eqm.nc"
# path_to_ncml_eqm="/home/ubuntu/scripts/thredds/ncml_files/ETA22/eqm/pp_$(date +%Y%m%d)_ens_eqm.ncml"
# path_to_updated_file_eqm="/home/ubuntu/data/thredds/public/pronostico_precipitacion/ETA22/eqm/corrected/pp_$(date +%Y%m%d)_corrected_ens_eqm.nc"
# path_to_ncml_eqm2="/home/ubuntu/scripts/thredds/ncml_files/ETA22/eqm/pp_$(date +%Y%m%d)_ens_eqm2.ncml"

# python /home/ubuntu/scripts/thredds/eta/correct_ncml_climate_change.py $path_to_file_eqm $path_to_ncml_eqm


# DEST_EQM=$path_to_ncml_eqm


# echo "Fixing eqm ETA22 data"
# sed -i "/'z'/s//'time'/" $path_to_ncml_eqm

# sed -i '/"z"/s//"time"/' $path_to_ncml_eqm

# sed -i '/"z"/s//"time"/' $path_to_ncml_eqm

# sed -i '3,9d' $path_to_ncml_eqm


# sed -i 's:\(<variable name="time".*\)\(>\):\1 orgName="z" \2:' $path_to_ncml_eqm

# source /home/ubuntu/miniconda3/bin/activate tethys

# python /home/ubuntu/scripts/thredds/eta/generate_climate_change.py $path_to_file_eqm $path_to_ncml_eqm $path_to_updated_file_eqm


# path_to_file_scal="/home/ubuntu/data/thredds/public/pronostico_precipitacion/ETA22/scal/pp_$(date +%Y%m%d)_ens_scal.nc"
# path_to_ncml_scal="/home/ubuntu/scripts/thredds/ncml_files/ETA22/scal/pp_$(date +%Y%m%d)_ens_scal.ncml"
# path_to_updated_file_scal="/home/ubuntu/data/thredds/public/pronostico_precipitacion/ETA22/scal/corrected/pp_$(date +%Y%m%d)_corrected_ens_scal.nc"
# path_to_ncml_scal2="/home/ubuntu/scripts/thredds/ncml_files/ETA22/scal/pp_$(date +%Y%m%d)_ens_scal2.ncml"

# python /home/ubuntu/scripts/thredds/eta/correct_ncml_climate_change.py $path_to_file_scal $path_to_ncml_scal

# DEST_SCAL=$path_to_ncml_scal

# echo "Fixing scal ETA22 data"

# sed -i "/'z'/s//'time'/" $path_to_ncml_scal

# sed -i '/"z"/s//"time"/' $path_to_ncml_scal


# sed -i '/"z"/s//"time"/' $path_to_ncml_scal

# sed -i '3,9d' $path_to_ncml_scal

# sed -i 's:\(<variable name="time".*\)\(>\):\1 orgName="z" \2:' $path_to_ncml_scal


# source /home/ubuntu/miniconda3/bin/activate tethys

# python /home/ubuntu/scripts/thredds/eta/generate_climate_change.py $path_to_file_scal $path_to_ncml_scal $path_to_updated_file_scal
