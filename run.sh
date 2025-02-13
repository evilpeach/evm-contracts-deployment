#!/bin/bash

PRIVATE_KEY=<PRIVATE_KEY>
JSON_RPC=https://json-rpc.minievm-2.initia.xyz
VERIFIER_URL=https://verification-staging.alleslabs.dev/evm/verification/solidity/external/minievm-2

# Storage
SOLC_VERSION=0.8.25
EVM_VERSION=london
OPTIMIZE=true
OPTIMIZE_RUNS=200
forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/Storage.sol:Storage

# MyToken
SOLC_VERSION=0.8.28
EVM_VERSION=cancun
OPTIMIZE=true
OPTIMIZE_RUNS=10000
NAME="Klua Token2"
SYMBOL="KLUA2"
DEPLOYED_ADDRESS=$(forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/MyToken.sol:MyToken \
 --constructor-args $NAME $SYMBOL | grep "Deployed to:" | cut -d ' ' -f 3)

# verify contract
forge verify-contract \
  --rpc-url $JSON_RPC \
  --verifier custom \
  --constructor-args $(cast abi-encode "constructor(string,string)" $NAME $SYMBOL) \
  --verifier-url $VERIFIER_URL \
  $DEPLOYED_ADDRESS \
  src/MyToken.sol:MyToken