SOLC_VERSION=0.8.28
EVM_VERSION=cancun
OPTIMIZE=true
OPTIMIZE_RUNS=500

# Deploy Logic contract
LOGIC_ADDRESS=$(forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/solidity/proxy/Logic.sol:Logic | grep "Deployed to:" | cut -d ' ' -f 3)

forge verify-contract \
  --rpc-url $JSON_RPC \
  --verifier custom \
  --verifier-url $VERIFIER_URL \
  $LOGIC_ADDRESS \
  src/solidity/proxy/Logic.sol:Logic

# Get owner address
OWNER_ADDRESS=$(cast wallet address $PRIVATE_KEY)

# Deploy Admin contract
ADMIN_ADDRESS=$(forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/solidity/proxy/Admin.sol:Admin --constructor-args $OWNER_ADDRESS | grep "Deployed to:" | cut -d ' ' -f 3)

forge verify-contract \
  --rpc-url $JSON_RPC \
  --verifier custom \
  --constructor-args $(cast abi-encode "constructor(address)" $OWNER_ADDRESS) \
  --verifier-url $VERIFIER_URL \
  $ADMIN_ADDRESS \
  src/solidity/proxy/Admin.sol:Admin

# Deploy Proxy contract
PROXY_ADDRESS=$(forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/solidity/proxy/Proxy.sol:Proxy \
 --constructor-args $LOGIC_ADDRESS $ADMIN_ADDRESS 0x | grep "Deployed to:" | cut -d ' ' -f 3)

forge verify-contract \
  --rpc-url $JSON_RPC \
  --verifier custom \
  --constructor-args $(cast abi-encode "constructor(address,address,bytes)" $LOGIC_ADDRESS $ADMIN_ADDRESS 0x) \
  --verifier-url $VERIFIER_URL \
  $PROXY_ADDRESS \
  src/solidity/proxy/Proxy.sol:Proxy