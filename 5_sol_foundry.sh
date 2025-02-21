# Clone this repository
git clone https://github.com/PaulRBerg/foundry-template.git
cd foundry-template

# Install dependencies
pnpm install

# Copy MyToken to src directory in your project

# Deploy contract
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
 --broadcast src/solidity/MyToken.sol:MyToken \
 --constructor-args $NAME $SYMBOL | grep "Deployed to:" | cut -d ' ' -f 3)

# PLEASE LOOK AT CONTRACT VERIFICATION IN SCAN FIRST
# USE THIS COMMAND AS REFERENCE
forge verify-contract \
  --rpc-url $JSON_RPC \
  --verifier custom \
  --constructor-args $(cast abi-encode "constructor(string,string)" $NAME $SYMBOL) \
  --verifier-url $VERIFIER_URL \
  $DEPLOYED_ADDRESS \
  src/solidity/MyToken.sol:MyToken