#!/bin/bash

echo "Downloading for $(date +%Y%m%d)"
USER=senamhi
PASSWORD=serviciosenamhi
date_download=$(date +%Y%m%d)
SOURCE_PRECIP="ftp://ftp.senamhi.gob.pe/HIDROLOGIA/GFS/${date_download}/pp_GFS_${date_download}.nc"
SOURCE_TEMP="ftp://ftp.senamhi.gob.pe/HIDROLOGIA/GFS/${date_download}/tp_GFS_${date_download}.nc"
base_gfs_thredds_path='/home/ubuntu/data/thredds/public/pronostico_precipitacion/GFS'

echo "Donwloading GFS Precipitation Data"

wget --user=$USER --password=$PASSWORD --directory-prefix=$base_gfs_thredds_path/precipitation $SOURCE_PRECIP
echo -e "latest file for precipitation GFS data: latest_gfs_pp.nc"
cp $base_gfs_thredds_path/precipitation/pp_GFS_${date_download}.nc $base_gfs_thredds_path/precipitation/latest_gfs_pp.nc

echo "Donwloading GFS Temperature Data"

wget --user=$USER --password=$PASSWORD --directory-prefix=$base_gfs_thredds_path/temperature $SOURCE_TEMP
echo -e "latest file for precipitation GFS data: latest_gfs_pp.nc"
cp $base_gfs_thredds_path/temperature/tp_GFS_${date_download}.nc $base_gfs_thredds_path/temperature/latest_gfs_tmp.nc
