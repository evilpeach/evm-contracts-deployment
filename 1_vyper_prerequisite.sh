# Install Python

# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# Install Vyper
pip install vyper
vyper --version # 0.4.0+commit.e9db8d9

# Install Foundry for cast cmd
curl -L https://foundry.paradigm.xyz | bash

# Setup environment variables
PRIVATE_KEY=<PRIVATE_KEY> # Replace with your private key
JSON_RPC=https://json-rpc.minievm-2.initia.xyz
