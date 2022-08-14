# Lottery-Smart-Contract
My first Smart Contract which uses Chainlink's VRF and OpenZeppelin's PaymentSplitter.

## Execution walkthrough

1. Deploy Chainlink's VRF contract (VRFv2Consumer.sol) with your VRF ID number. Once deployed, use the address of the contract to add it as a consumer in your subscription. Documentation on how to do this can be found [here](https://docs.chain.link/docs/chainlink-vrf/#:~:text=Chainlink%20VRF%20(Verifiable%20Random%20Function,without%20compromising%20security%20or%20usability.)).

2. Deploy Lottery.sol contract. If needed, change constant variables TICKET_COST and CAP (If you want x players, make sure CAP is x+1) 

3. Once all players are in, call _callVRF function_ with the deployed VRF's contract address 

4. All functions will get called and executed automatically. 

5. Once the transaction has been confirmed, the funds will be in the Payment contract (address found in sendFundsTo). Copy and paste this address in Remix's "At Address" function—under the deploy tab—to call the contract. **_Make sure you have the "Payments - contracts/Payments.sol" contract selected in the Contract's drop-down menu._**

6. Only the winner or owner can get their share when they call the "release: address account" function with their wallet address. 

## Current bugs

* If the retrieve() function gets executed many times at once from external calls, they'll get pushed into the player's list even going beyond the CAP limitation. I'm guessing this has something to do with block confirmation numbers and will try to find a solution in the future. 
