# DERO <-> BTC

`Proof of concept`

Trustless atomic swap between DERO and BTC.  
This is just a proposal and everything still needs to be done. I've included a possible Dero Smart Contract as an example.  

## Why

Ability to exchange native BTC for DERO without CEX or any kind of Trusted Exchange Model. Showcase the power of both scripting language that enable two anonym parties to cross-chain exchange trustlessly. Straight up from native BTC token instead of Ethereum WBTC.

## How

1. Both parties exchange hash secrets, recipient address and deploy smart contract on their respective blockchain.

2. Both must verifity integrity of contract code and exchange details: timelock, amount, recipient address and secret hash. (Verification can be done by client side code)

3. Only one party needs to reveal his secret key to the other party. The other party must use both secret to retrieve the funds. So, the party that reveal the secret must periodically check that the other party has fulfilled the transaction to get the other secret. He can now retrieve funds with both keys.

### Notes

1. If no secret is reveal because of various reasons, both parties must wait for the timelock to expire before unlocking their funds.

2. Even if one party has both secret, he cannot retrieve his own funds because only the recipient address can unlock them with both keys. This is why it's important to verify integrity of smart contract and details before revealing secret key.

3. Even if someone that is not part of the transaction capture both keys, he can't retrieve the funds because he must be the recipient signer assign to the smart contract.

4. The party with both secret could wait last minute and sign the transaction. Leaving the other party unable to get the other secret in time. Resulting in lost funds. This can be avoid if the party that reveal the key has always a way bigger timelock than the other.

5. Timelock could scale based on the amount being exchanged. Smaller transaction can use lower timelock and bigger transaction with longer timelock.

6. Think about blockchain block time diff: btc ~10min <-> dero ~18s

## Q/A

1. Can this be done with Monero/XMR?

No because XMR does not have smart contract capabilities and does not have any timelock transaction
<https://github.com/comit-network/xmr-btc-swap/issues/688#issuecomment-908863184>. However you can use cross-chain atomic swap with wallets and layer 2 solution but I believe this method is not completely trustless. For instance: <https://github.com/comit-network/xmr-btc-swap>

I think this is use for smaller transactions between trusted parties, rather than trustless transactions between complete strangers. IMO this makes Monero even less practical than Bitcoin.
