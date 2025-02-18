import type { DeployFunction } from 'hardhat-deploy/types'
import type { HardhatRuntimeEnvironment } from 'hardhat/types'

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deploy } = hre.deployments
  const { deployer } = await hre.getNamedAccounts()

  const Salesperson = await deploy('Salesperson', {
    from: deployer,
    args: [55555, 12345, 20]
  })

  const EngineeringManager = await deploy('EngineeringManager', {
    from: deployer,
    args: [54321, 11111, 200_000]
  })

  const InheritanceSubmission = await deploy('InheritanceSubmission', {
    from: deployer,
    args: [Salesperson.address, EngineeringManager.address]
  })

  console.log('Deployed at address:', InheritanceSubmission.address)
}

export default func

func.tags = ['InheritanceSubmission']
