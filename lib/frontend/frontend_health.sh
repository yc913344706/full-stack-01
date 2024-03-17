#!/bin/bash

LOG_FILE="/var/log/nginx/restart-frontend.log"

main()
{
  if [ "$(curl  -s -o /dev/null -w "%{http_code}" localhost:80)" -eq 200 ]; then
    exit 0
  else
    echo "$(date): httpcode is not 200, restart frontend container" >> ${LOG_FILE}
    kill 1
    exit 1
  fi
}

main >> ${LOG_FILE} 2>&1
