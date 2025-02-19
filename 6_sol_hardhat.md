# Create Hardhat project

```sh
mkdir hardhat-project
cd hardhat-project
```

# Initialize Hardhat project

```sh
npx hardhat init
# Choose Typescript and yes all
```

# Add network to `hardhat.config.ts`

```ts
const config: HardhatUserConfig = {
  solidity: "0.8.27",
  networks: {
    "minievm-2": {
      url: "https://json-rpc.minievm-2.initia.xyz",
      accounts: ["PRIVATE_KEY_WITHOUT_0X_PREFIX"],
    },
  },
};
```

# Compile contract

```sh
npx hardhat compile
```

# Deploy contract

```sh
npx hardhat ignition deploy ./ignition/modules/Lock.ts --network minievm-2
```

# Get constructor arguments

```sh
cast abi-encode "constructor(uint)" 1893456000
```
