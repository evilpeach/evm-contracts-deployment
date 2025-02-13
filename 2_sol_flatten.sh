# !/bin/bash

# This script can be used to deploy a contract.
# It can also be used to verify a contract via the flatten and upload files method.
# Case 1: Normal deployment
SOLC_VERSION=0.8.28
EVM_VERSION=cancun
OPTIMIZE=false
OPTIMIZE_RUNS=200
forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/Storage.sol:Storage

# Get contract code for verification
forge flatten src/Storage.sol | pbcopy

# Case 2: Deployment with constructor arguments and optimization runs
SOLC_VERSION=0.8.26
EVM_VERSION=paris
OPTIMIZE=true
OPTIMIZE_RUNS=10000
ARGUMENT=8888
forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/StorageArgs.sol:StorageArgs \
 --constructor-args $ARGUMENT

cast abi-encode "constructor(uint256)" $ARGUMENT