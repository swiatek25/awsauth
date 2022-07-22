#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run with 'sudo'"
  exit
fi

COMPLETIONS_DIR=/etc/bash_completion.d
LOCAL_SCRIPTS_DIR=/usr/local/bin

cp ./templates/autocomplete.tmpl ${COMPLETIONS_DIR}/awsauth.bash
cp ./templates/awsauth.tmpl ${LOCAL_SCRIPTS_DIR}/awsauth
chmod +x ${LOCAL_SCRIPTS_DIR}/awsauth

echo -e "All OK. \nStart a new shell and run 'awsauth'."