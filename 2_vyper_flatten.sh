# Case 1: Normal
EVM_VERSION=paris
COMPILED_BYTECODE=$(vyper src/vyper/hello_world.vy --evm-version $EVM_VERSION)
cast send --private-key $PRIVATE_KEY --rpc-url $JSON_RPC --create $COMPILED_BYTECODE

# Case 2: With constructor
EVM_VERSION=cancun
NAME=Test
DURATION=888
COMPILED_BYTECODE=$(vyper src/vyper/with_constructor.vy --evm-version $EVM_VERSION)
COMPILED_BYTECODE+=$(cast abi-encode "constructor(string,uint256)" $NAME $DURATION | sed 's/^0x//')
cast send --private-key $PRIVATE_KEY --rpc-url $JSON_RPC --create $COMPILED_BYTECODE

# Get constructor arguments
cast abi-encode "constructor(string,uint256)" $NAME $DURATION
