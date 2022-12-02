#!/bin/bash
set -e

SLASHING_DATA_FILE=$1

for key in /keystore/validator_keys/*; do
  if [ -f "$key" ]; then
    echo "Found validator key in $key"
    echo "Importing validator..."
    if [ $VAL_NETWORK = "CUSTOM" ]; then
      ./lighthouse account validator import --testnet-dir /network_config --password-file /keystore/keystore_password.txt --keystore $key --reuse-password --datadir /data  
    else
      ./lighthouse account validator import --network $VAL_NETWORK --password-file /keystore/keystore_password.txt --keystore $key --reuse-password --datadir /data
    fi
    echo "Validator imported"
  fi
done

if [ -f "$SLASHING_DATA_FILE" ]; then
  echo "Found slashing interchange data in $SLASHING_DATA_FILE"
  echo "Importing slashing data..."
  lighthouse account validator slashing-protection import $SLASHING_DATA_FILE
  echo "Slashing data imported"
fi
