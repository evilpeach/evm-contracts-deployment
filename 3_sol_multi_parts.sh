SOLC_VERSION=0.8.27
EVM_VERSION=shanghai
OPTIMIZE=true
OPTIMIZE_RUNS=10000

forge create \
  --rpc-url $JSON_RPC \
  --private-key $PRIVATE_KEY \
  --use $SOLC_VERSION \
  --evm-version $EVM_VERSION \
  --optimize $OPTIMIZE \
  --optimizer-runs $OPTIMIZE_RUNS \
  --broadcast src/solidity/multi-parts/MainContract.sol:MainContract