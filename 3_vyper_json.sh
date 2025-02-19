# For Standard JSON Input
# We can use --optimize codesize to reduce the size of the contract

EVM_VERSION=shanghai
OPTIMIZE=codesize
COMPILED_BYTECODE=$(vyper src/vyper/hello_world.vy --evm-version $EVM_VERSION --optimize $OPTIMIZE)
cast send --private-key $PRIVATE_KEY --rpc-url $JSON_RPC --create $COMPILED_BYTECODE

# With Constructor
EVM_VERSION=cancun
OPTIMIZE=gas
NAME=Test
DURATION=888
COMPILED_BYTECODE=$(vyper src/vyper/with_constructor.vy --evm-version $EVM_VERSION --optimize $OPTIMIZE)
COMPILED_BYTECODE+=$(cast abi-encode "constructor(string,uint256)" $NAME $DURATION | sed 's/^0x//')
cast send --private-key $PRIVATE_KEY --rpc-url $JSON_RPC --create $COMPILED_BYTECODE

# Get constructor arguments
cast abi-encode "constructor(string,uint256)" $NAME $DURATION