# Base Learn Exercises

All the smart contracts I coded along with [Base Learn](https://docs.base.org/learn/welcome) are publicly available in here.

Remember to create a new `.env` file according to [`.env.example`](./.env.example).

> If you're not a fan of Alchemy, you can use [the official RPC URLs from Base](https://docs.base.org/docs/quickstart#1-set-up-your-node-connection) or [any other the node providers here](https://docs.base.org/docs/tools/node-providers).
>
> Just replace the environment variables correctly in `.env` and [`index.d.ts`](./types/index.d.ts).

## Deployment

```sh
npm run deploy -- --tags <TAG>
```

For example, I want to deploy the contract named [`BasicMath`](./contracts/Deploying/BasicMath.sol), I use the tag declared in [00_deploy_BasicMath.ts](./deploy/00_deploy_BasicMath.ts) (deployment file):

```sh
npm run deploy -- --tags BasicMath
```

## Contract verification

```sh
npm run verify
```
