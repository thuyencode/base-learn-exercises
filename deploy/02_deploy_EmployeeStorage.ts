import type { DeployFunction } from 'hardhat-deploy/types'
import type { HardhatRuntimeEnvironment } from 'hardhat/types'

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deploy } = hre.deployments
  const { deployer } = await hre.getNamedAccounts()

  const SHARES = 1000
  const NAME = 'Pat'
  const SALARY = 5000
  const ID_NUMBER = 112358132134

  const deployment = await deploy('EmployeeStorage', {
    from: deployer,
    args: [SHARES, NAME, SALARY, ID_NUMBER]
  })

  console.log('Deployed at address:', deployment.address)
}

export default func

func.tags = ['EmployeeStorage']
