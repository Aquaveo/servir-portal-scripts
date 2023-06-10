#!/bin/bash

USER=senamhi
PASSWORD=serviciosenamhi

products=("eqm" "scal")
date_download = $(date +%Y%m%d)
eta_base_path=/home/ubuntu/data/thredds/public/ETA22
for product in ${products[@]}; do

    # defining variables
    SOURCE_PRECIP_DET="ftp://ftp.senamhi.gob.pe/HIDROLOGIA/ETA22_grilla/eqm/pp_${date_download}_${product}.nc"
    SOURCE_TEMP_DET_1="ftp://ftp.senamhi.gob.pe/HIDROLOGIA/ETA22_grilla/eqm/tx_${date_download}_${product}.nc"
    SOURCE_TEMP_DET_2="ftp://ftp.senamhi.gob.pe/HIDROLOGIA/ETA22_grilla/eqm/tn_${date_download}_${product}.nc"
    SOURCE_ENS="ftp://ftp.senamhi.gob.pe/HIDROLOGIA/ETA22_grilla/eqm/ENS/pp_${date_download}_ens_${product}.nc"
    
    # Downloading the data
    echo "Downloading $product ETA22 data"

    echo "Downloading Precip Det"
    wget --user=$USER --password=$PASSWORD --directory-prefix=${eta_base_path}/$product/determinista/precipitation $SOURCE_PRECIP_DET    

    echo "Downloading Temp Det 1"
    wget --user=$USER --password=$PASSWORD --directory-prefix=${eta_base_path}/$product/determinista/temperature $SOURCE_TEMP_DET_1

    echo "Downloading Temp Det 2"
    wget --user=$USER --password=$PASSWORD --directory-prefix=${eta_base_path}/$product/determinista/temperature $SOURCE_TEMP_DET_2

    echo "Downloading Ensemble"
    wget --user=$USER --password=$PASSWORD --directory-prefix=${eta_base_path}/$product/determinista/ensemble $SOURCE_ENS
    
    echo "Finishing Data Dowloadig for $product ETA22 data"

done

