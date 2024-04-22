#!/bin/bash

SCRIPT=$(readlink -f "$0")
WORKDIR=$(dirname "$SCRIPT")

ALLOWFILE=$WORKDIR/hosts_sshd.allow
DOMAINFILE=$WORKDIR/allowed_domain.list

DOMAINS=$(cat $DOMAINFILE |grep -v "^#")

echo "# automatic generated : $(date)" > $ALLOWFILE
for DOMAIN in $DOMAINS
  do
    echo ""
    IP=$(dig $DOMAIN A | grep "^$DOMAIN" | sed -e 's/\s\s*/ /g' | cut -d " " -f5)
    echo "# $DOMAIN"
    echo $IP
    echo
  done  >> $ALLOWFILE
