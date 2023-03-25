// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Lottery {


    address private owner;
    Winner[5] private winners;
    uint private tempBalanceS;
    uint private tempBalanceM;
    uint private tempBalanceL;
    uint private tempBalanceX;

    struct Winner{
        address _address;
        uint amount;
        uint time;
    }
    
    constructor () {
        owner = msg.sender;
    }



    function withdraw() external {
        require(msg.sender == owner, "The sender must be the owner");
        payable(owner).transfer(address(this).balance);
    }


    function playS() external payable returns (bool){
        require(msg.value < 25 ether, "Value must be lower than 25 Ether");
        tempBalanceS += msg.value;
        if(tempBalanceS > 25 ether){
            tempBalanceS = 0;
            setWinners(25 ether);
            return(true);
        }else{
            return(false);
        }
    }

    function playM() external payable returns (bool){
        require(msg.value < 100 ether, "Value must be lower than 100 Ether");
        tempBalanceM += msg.value;
        if(tempBalanceM > 100 ether){
            tempBalanceM = 0;
            setWinners(100 ether);
            return(true);
        }else{
            return(false);
        }
    }

    function playL() external payable returns (bool){
        require(msg.value < 250 ether, "Value must be lower than 250 Ether");
        tempBalanceL += msg.value;
        if(tempBalanceL > 250 ether){
            tempBalanceL = 0;
            setWinners(250 ether);
            return(true);
        }else{
            return(false);
        }
    }


    function playX() external payable returns (bool){
        require(msg.value < 1000 ether, "Value must be lower than 1000 Ether");
        tempBalanceX += msg.value;
        if(tempBalanceX > 1000 ether){
            tempBalanceX = 0;
            setWinners(1000 ether);
            return(true);
        }else{
            return(false);
        }
    }


    function setWinners(uint amount) internal {
        payable(msg.sender).transfer(amount);
        payable(owner).transfer(address(this).balance);
        for(uint i = 4; i >= 0; i--){
                winners[i+1] = winners[i];
        }
        Winner memory newWinner;
        newWinner._address = msg.sender;
        newWinner.amount=amount;
        newWinner.time=block.timestamp;
        winners[0] = newWinner;
    }


    function getWinners() external view returns (Winner[5] memory){
        return winners;
    }



}
