# Lottery-Smart-Contract
My first Smart Contract, using Chainlink's VRF and OpenZeppelin's PaymentSplitter

VRFv2Consumer is Chainlink's VRF contract.\
Payments inherits the PaymentSplitter contract and is used to pass the winner and owner addresses, as well as the distribution (50, 50) of funds. 

**TO RUN THE PROGRAM**\
1.) Deploy Chainlink's VRF contract with your VRF ID number. Once deployed, use the address of the contract to add it as a consumer in your subscription. Documentation on how to do this found [here](https://docs.chain.link/docs/chainlink-vrf/#:~:text=Chainlink%20VRF%20(Verifiable%20Random%20Function,without%20compromising%20security%20or%20usability.)
