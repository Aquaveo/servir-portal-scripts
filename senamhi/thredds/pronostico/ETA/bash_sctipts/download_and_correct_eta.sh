#!/bin/bash

echo "Downloading for $(date +%Y%m%d)"

bash /home/ubuntu/scripts/thredds/eta/download_eta.sh
bash /home/ubuntu/scripts/thredds/eta/correct_eta_data.sh 
