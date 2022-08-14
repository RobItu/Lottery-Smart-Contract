//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ChainlinkVRFv2.sol";
import "./Payments.sol";

error NotOwner();

contract Lottery{

    VRFv2Consumer vrfContract; //instance of VRFv2Consumer object that will be used in getRandomIndex() to obtain VRF's number.
    Payments splitFunds; // Payments object. Payments is paymentSplitter contract.

    uint256 constant TICKET_COST = 1*1e16; 
    uint256 constant CAP = 4; // How many players are allowed to play?
    address immutable owner;

    address[] public players;
    mapping(address => bool) isPlayer;
    uint256[] public randomWord; // variable to catch the output of VRF
    address public winner;

    address payable public sendFundsTo; //Variable that will catch the address of paymentSplitter contract
    address[] withdrawersList; //List of the people who are able to withdraw their funds. (Owner and winner)
    uint256[]  _sharesList = [50, 50]; //How the funds will be split (50% for both addresses)

    constructor()  {
         owner = msg.sender;
         withdrawersList.push(msg.sender);
    }

    function fund() payable public {
        require(players.length < CAP);
        require(msg.value >= TICKET_COST);
        require(isPlayer[msg.sender] == false, "You are already in"); //prevents double entry

        players.push(msg.sender);
        isPlayer[msg.sender] = true;
    }

    function callVRF(address _VRFcontract) public OnlyOwner {
        assert(players.length < CAP);
        vrfContract = VRFv2Consumer(_VRFcontract); //Takes address of deployed VRF contract
        getRandomIndex();
    }

    function getRandomIndex() internal OnlyOwner returns(uint256){
        
        randomWord = vrfContract.sendNumber(); //VRF random number in array
        uint256 rNumber = randomWord[0];
        rNumber = rNumber%players.length; // Getting a random value from range of player's list
        chooseWinner(rNumber);
        return rNumber;
    }

    function chooseWinner(uint256 index) internal{
        winner = players[index];
        withdrawersList.push(winner);
        withdraw();
    }

    function withdraw() internal {
        splitFunds = new Payments(withdrawersList, _sharesList);    //initiation of the paymentSplitter contract.
        sendFundsTo = payable(address(splitFunds));
        (bool callSuccess,) = payable(sendFundsTo).call{value: address(this).balance}("");
        require(callSuccess, "Call failed.");
        
    }

    modifier OnlyOwner {
        if(msg.sender != owner){revert NotOwner();}
        _;
    }

    receive() payable external {
        fund();
    }

    fallback() external {
        fund();
    }



} 
