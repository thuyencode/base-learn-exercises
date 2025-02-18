declare global {
  namespace NodeJS {
    interface ProcessEnv {
      MNENOMIC: string
      ALCHEMY_API_KEY: string
      BASE_SEPOLIA_RPC_URL: string
      BASESCAN_API_KEY: string
      BASESCAN_SEPOLIA_API_URL: string
    }
  }
}

export {}
