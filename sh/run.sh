#!/bin/sh
# This is an entrypoint for the opendkim container.
# By: Isca
#set -x

#####################
# OPTIONS:
# Here is the options you can use as environment:
# 
# * domain: yourdomain.com - use to specify your domain
# * keyfile: somepath - specify the path for your private key
# * inthosts: 192.168.0.0/24 10.0.0.2 - specidy your internal hosts with spaces.
#
#####################

odk="/etc/opendkim"
odkconf=""$odk"/opendkim.conf"
initated=""$odk"/isced"
domainset="${domain:-example.com}"
keyfileset="${keyfile:-$odk/keys/$domainset/$domainset.private}"
hostsset="${inthosts:-0.0.0.0/0}"

gen_key(){
  
  echo "========= Creating Domain $domainset Key ========="
  if [ ! -d "$odk"/keys/$domainset ];then
    mkdir -p "$odk"/keys/"$domainset"
    opendkim-genkey -s $domainset -d "$domainset" --directory="$odk"/keys/"$domainset"/
    if [ "$?" == 0 ];then
      echo "Dkim Key Generated with Success in $odk/keys/$domainset/$domainset.private whith value: "
      cat $odk/keys/$domainset/$domainset.private
      cat $odk/keys/$domainset/$domainset.txt
    fi
  fi


}

conf_dkim(){

  sed -i -e "s,DOMAIN,${domainset}g," \
         -e "s,^KeyFile.*\$,KeyFile\t\t\t${keyfileset}," "$odkconf"
  echo -e "InternalHosts\t\t$hostsset" >> "$odkconf"
  cat "$odkconf"

}

start(){

  if [ ! -e "$initated" ];then
    gen_key
  fi
  socat UNIX-RECV:/dev/log,mode=666 STDOUT &
  conf_dkim
  exec opendkim -vfx "$odkconf"
}

start
