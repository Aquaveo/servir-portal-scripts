#!/bin/bash

echo "Downloading for $(date +%Y%m%d)"

#Download the ETA data
bash /home/ubuntu/scripts/thredds/eta/download_eta.sh
#Correct the ETA data
bash /home/ubuntu/scripts/thredds/eta/correct_eta_data.sh