import '@nomicfoundation/hardhat-toolbox'
import dotenv from 'dotenv'
import dotenvExpand from 'dotenv-expand'
import 'hardhat-deploy'
import { HardhatUserConfig } from 'hardhat/config'

dotenvExpand.expand(dotenv.config())

const config: HardhatUserConfig = {
  solidity: {
    version: '0.8.20',
    settings: { optimizer: { enabled: true, runs: 200 } }
  },
  namedAccounts: {
    deployer: 0
  },
  networks: {
    base_sepolia: {
      url: process.env.BASE_SEPOLIA_RPC_URL,
      accounts: {
        mnemonic: process.env.MNENOMIC ?? ''
      },
      verify: {
        etherscan: {
          apiUrl: process.env.BASESCAN_SEPOLIA_API_URL,
          apiKey: process.env.BASESCAN_API_KEY
        }
      }
    }
  }
}

export default config
