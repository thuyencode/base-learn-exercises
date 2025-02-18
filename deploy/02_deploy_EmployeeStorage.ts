import type { DeployFunction } from 'hardhat-deploy/types'
import type { HardhatRuntimeEnvironment } from 'hardhat/types'

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deploy } = hre.deployments
  const { deployer } = await hre.getNamedAccounts()

  const SHARES = 1000
  const NAME = 'Pat'
  const SALARY = 5000
  const ID_NUMBER = 112358132134

  await deploy('EmployeeStorage', {
    from: deployer,
    args: [SHARES, NAME, SALARY, ID_NUMBER]
  })
}

export default func

func.tags = ['EmployeeStorage']
