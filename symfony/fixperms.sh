#!/bin/bash

if [ $# -gt 0 ]; then
  argList=(--set-all --set-user --set-httpd)
  match=0
  for arg in "${argList[@]}"; do
    if [[ $1 = $arg ]];
    then
      match=1
      break
    fi
  done

  if [[ $match = 0 ]]; then
    echo "Invalid argument supplied. Chose one of the following : "
    
    for arg in "${argList[@]}"; do
      echo "    $arg"
    done

    exit
  fi
fi

echo ""
echo "#########################"
echo "# PERMISSIONS"
echo "#########################"

user=$(whoami)
httpd=$(ps axho user,comm|grep -E "httpd|apache"|uniq|grep -v "root"|awk 'END {if ($1) print $1}')

if [ $# -gt 0 ]; then
  if [[ $1 = "--set-all" ]]; then
    read -p "# User who can write the DIR ? " user
    read -p "# Httpd user ? " httpd
  else
    if [[ $1 = "--set-user" ]]; then
      read -p "# User who can write the DIR ? " user
    elif [[ $1 = "--set-httpd" ]]; then
      read -p "# Httpd user ? " httpd
    fi
  fi
fi

echo "# Setting permissions"
#chown -R $user:$user .
#chown -R $user:$httpd app/cache app/logs
#chmod -R u+w .
#chmod -R g+w app/cache app/logs
echo "# Permissions set for $user and $httpd."
