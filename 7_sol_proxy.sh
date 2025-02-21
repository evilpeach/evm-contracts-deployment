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
ADMIN_ADDRESS=$(cast wallet address $PRIVATE_KEY)

# Deploy Proxy contract
PROXY_ADDRESS=$(forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/solidity/proxy/Proxy.sol:Proxy \
 --constructor-args $LOGIC_ADDRESS $ADMIN_ADDRESS 0x | grep "Deployed to:" | cut -d ' ' -f 3)

# Verify Proxy contract
forge verify-contract \
  --rpc-url $JSON_RPC \
  --verifier custom \
  --constructor-args $(cast abi-encode "constructor(address,address,bytes)" $LOGIC_ADDRESS $ADMIN_ADDRESS 0x) \
  --verifier-url $VERIFIER_URL \
  $PROXY_ADDRESS \
  src/solidity/proxy/Proxy.sol:Proxy

PROXY_ADMIN_ADDRESS=<PROXY_ADMIN_ADDRESS>
# Verify Admin contract
forge verify-contract \
  --rpc-url $JSON_RPC \
  --verifier custom \
  --verifier-url $VERIFIER_URL \
  $PROXY_ADMIN_ADDRESS \
  node_modules/@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol:ProxyAdmin


# Upgrade the contract
# Deploy new Logic contract
LOGIC_ADDRESS_v2=$(forge create --rpc-url $JSON_RPC \
 --private-key $PRIVATE_KEY \
 --use $SOLC_VERSION \
 --evm-version $EVM_VERSION \
 --optimize $OPTIMIZE \
 --optimizer-runs $OPTIMIZE_RUNS \
 --broadcast src/solidity/proxy/LogicV2.sol:LogicV2 | grep "Deployed to:" | cut -d ' ' -f 3)

forge verify-contract \
  --rpc-url $JSON_RPC \
  --verifier custom \
  --verifier-url $VERIFIER_URL \
  $LOGIC_ADDRESS_v2 \
  src/solidity/proxy/LogicV2.sol:LogicV2