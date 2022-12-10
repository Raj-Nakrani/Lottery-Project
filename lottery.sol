// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract lottery {

    address payable[] public participant;
    address public manager;

    constructor(){
        manager=msg.sender;
    }

    receive() external payable{
        require(msg.value==1 ether);
        participant.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
         require(manager==msg.sender);
        return address(this).balance;
    }
    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participant.length)));
    }

    function winners()public{
        require(msg.sender==manager);
        require(participant.length>=3);
        uint r=random();
        address payable winner;
        uint index= r % participant.length;
         winner=participant[index];
         
         winner.transfer(getBalance());

        participant=new address payable[](0);

        
    }

}