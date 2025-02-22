import type { DeployFunction } from 'hardhat-deploy/types'
import type { HardhatRuntimeEnvironment } from 'hardhat/types'

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deploy } = hre.deployments
  const { deployer } = await hre.getNamedAccounts()

  const deployment = await deploy('HaikuNFT', {
    from: deployer,
    args: ['HaikuNFT', 'HAIKU']
  })

  console.log('Deployed at address:', deployment.address)
}

export default func

func.tags = ['HaikuNFT']
