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
 --broadcast src/solidity/Storage.sol:Storage

# Get contract code for verification
forge flatten src/solidity/Storage.sol | pbcopy

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
 --broadcast src/solidity/StorageArgs.sol:StorageArgs \
 --constructor-args $ARGUMENT

# Get the constructor arguments
cast abi-encode "constructor(uint256)" $ARGUMENT

# Case 3: With a libraries
SOLC_VERSION=0.8.26
EVM_VERSION=paris
OPTIMIZE=true
OPTIMIZE_RUNS=10000

# Deploy the libraries
MATH_LIBRARY_ADDRESS=$(forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/solidity/libraries/MathLibrary.sol:MathLibrary | grep "Deployed to:" | cut -d ' ' -f 3)

MULTIPLY_LIBRARY_ADDRESS=$(forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/solidity/libraries/MultiplyLibrary.sol:MultiplyLibrary | grep "Deployed to:" | cut -d ' ' -f 3)

DIVIDE_LIBRARY_ADDRESS=$(forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/solidity/libraries/DivideLibrary.sol:DivideLibrary | grep "Deployed to:" | cut -d ' ' -f 3)

# Deploy the main contract
forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --libraries src/solidity/libraries/MathLibrary.sol:MathLibrary:$MATH_LIBRARY_ADDRESS \
 --libraries src/solidity/libraries/MultiplyLibrary.sol:MultiplyLibrary:$MULTIPLY_LIBRARY_ADDRESS \
 --libraries src/solidity/libraries/DivideLibrary.sol:DivideLibrary:$DIVIDE_LIBRARY_ADDRESS \
 --broadcast src/solidity/Calculator.sol:Calculator