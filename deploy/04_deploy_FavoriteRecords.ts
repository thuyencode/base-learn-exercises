import type { DeployFunction } from 'hardhat-deploy/types'
import type { HardhatRuntimeEnvironment } from 'hardhat/types'

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deploy } = hre.deployments
  const { deployer } = await hre.getNamedAccounts()

  const ALBUMS = [
    'Thriller',
    'Back in Black',
    'The Bodyguard',
    'The Dark Side of the Moon',
    'Their Greatest Hits (1971-1975)',
    'Hotel California',
    'Come On Over',
    'Rumours',
    'Saturday Night Fever'
  ]

  const deployment = await deploy('FavoriteRecords', {
    from: deployer,
    args: [ALBUMS]
  })

  console.log('Deployed at address:', deployment.address)
}

export default func

func.tags = ['FavoriteRecords']
