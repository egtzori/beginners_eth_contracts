// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Voting {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
        bool exists;
    }

    
    mapping(uint => Candidate) public candidates; // Store Candidates
    mapping(address => bool) public alreadyVoted;
    uint public candidatesCount = 0; // Store Candidates Count
    bool public ended = false;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor () {
        addCandidate("Brian");
        addCandidate("Peter");
        addCandidate("Jana");
        addCandidate("Suzy");
    }

    // add new candidate, starts with 0 votes
    function addCandidate (string memory _name) private {
        require(!ended, "voting has ended");
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0, true);
        candidatesCount ++;
    }

    // actual vode, sanity checks & increment vote count
    function vote (uint _candidateId) public {
        require(!ended, "voting has ended");
        require(!alreadyVoted[msg.sender], "each address can vote once");
        require(candidates[_candidateId].exists, "supply valid candidate id");
        candidates[_candidateId].voteCount ++;
        alreadyVoted[msg.sender] = true;
        emit votedEvent(_candidateId);
    }


    // return all candidates
    function list() public view returns(Candidate [] memory){
        Candidate[] memory ret = new Candidate[](candidatesCount);
        for (uint i=0; i<candidatesCount; i++) {
            ret[i] = candidates[i];
        }
        return ret;
    }

    // mark end of vote
    function endVoting() public {
        require(ended == false, "Voting already ended");
        ended = true;
    }

    // get current winner name or
    function getWinner() public view returns(string memory) {
        string memory winner = "";
        uint maxVotes = 0;
        for (uint i=0; i<candidatesCount; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
            }
        }

        for (uint i=0; i<candidatesCount; i++) {
            if (candidates[i].voteCount == maxVotes) {
                if (i != 0) {
                    winner = string.concat(winner, ' '); // prepend space ' '
                }
                winner = string.concat(winner, candidates[i].name);
            }
        }
        return winner;
    }
}
