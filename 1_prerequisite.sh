#!/bin/bash

# Install Foundry
curl -L https://foundry.paradigm.xyz | bash

forge --version
# forge 0.3.0 (5a8bd89 2024-12-20T08:45:53.204298000Z)

# Setup environment variables
PRIVATE_KEY=<PRIVATE_KEY> # Replace with your private key
JSON_RPC=https://json-rpc.minievm-2.initia.xyz
VERIFIER_URL=https://verification-staging.alleslabs.dev/evm/verification/solidity/external/minievm-2
