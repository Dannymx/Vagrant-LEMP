#!/bin/bash

aptitude install -y postfix

# git
echo ""
echo "#########################"
echo "#     POSTFIX CONF      #"
echo "#########################"
read -p "Add your domain to the config files : " domain_name
postconf -e "myorigin = ${domain_name}"
postconf -e "myhostname = `hostname`"
read -p "Add additionnals domains names that your system will handle : " domain_name_alt
while [ -n "$1" ]
  do
    domain_names_alt = ", ${domain_name_alt}"
done
postconf -e "relay_domains = ${domain_name}${domain_names_alt}"
postfix reload
