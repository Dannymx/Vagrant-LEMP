#!/bin/bash


echo ""
echo "#########################"
echo "# PERMISSIONS"
echo "#########################"
read -p "# User who can write the DIR ? " user
read -p "# Httpd user ? " httpd
echo "# Setting permissions"
chown -R $user:$user .
chown -R $user:$httpd app/cache app/logs
chmod -R u+w .
chmod -R g+w app/cache app/logs
