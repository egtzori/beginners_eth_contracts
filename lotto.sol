// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Lotto {
    uint public constant RTP = 95; // casino takes 5%
    uint32 public constant BET_AMOUNT_ETHER = 1; // will only accept this amount in ether
    address public owner;
    address payable[] public players;
    uint256 totalBet;

    constructor() {
        owner = msg.sender;
        totalBet = 0;
    }

    // put bet into pool - accepts only 1 ether
    // same player (address) can bet more than once
    function bet() public payable {
        require(msg.value == getEtherValue(BET_AMOUNT_ETHER), "Bet amount not supported - check BET_AMOUNT_ETHER variable");
        players.push(payable(msg.sender));
        totalBet += BET_AMOUNT_ETHER;
    }

    // non crypto random number
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players)));
    }

    // "play" the game - one random winner get everything - casino cut
    function playAndPayWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(address(this).balance * RTP / 100); // pay a
        players = new address payable[](0); // new game - remove all players
    }

    modifier restricted() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // return all players in game
    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }

    // helper, input value in ether, returns wei
    function getEtherValue(uint valueInEther) public pure returns (uint256) {
        return valueInEther * 1 ether; // in wei
    }
}