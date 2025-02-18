# DO NOT CHANGE ANYTHING
SOLC_VERSION=0.8.27
EVM_VERSION=cancun
OPTIMIZE=true
OPTIMIZE_RUNS=9999
NAME="Test Token"
SYMBOL="TEST"
forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/solidity/MyToken.sol:MyToken \
 --constructor-args $NAME $SYMBOL

# Please use src/solidity/json-input/MyToken.json to upload file

# Get constructor arguments and copy to clipboard
cast abi-encode "constructor(string, string)" $NAME $SYMBOL | pbcopy