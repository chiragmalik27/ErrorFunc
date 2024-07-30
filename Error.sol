// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Contestant {
        string name;
        uint voteCount;
    }

    address public chairperson;
    mapping(address => bool) public voters;
    Contestant[] public contestants;

    constructor(string[] memory contestantNames) {
        chairperson = msg.sender;
        _createContestants(contestantNames);
    }

    modifier onlyChairperson() {
        require(msg.sender == chairperson, "Only chairperson can call this function.");
        _;
    }

    function registerVoter(address voter) public onlyChairperson {
        _registerVoter(voter);
    }

    function vote(uint contestantIndex) public {
        _vote(contestantIndex);
    }

    function winningContestant() public view returns (uint winningContestant_) {
        return _winningContestant();
    }

    function endVoting() public onlyChairperson {
        _endVoting();
    }

    function _createContestants(string[] memory contestantNames) internal {
        for (uint i = 0; i < contestantNames.length; i++) {
            contestants.push(Contestant({
                name: contestantNames[i],
                voteCount: 0
            }));
        }
    }

    function _registerVoter(address voter) internal {
        require(!voters[voter], "Voter is already registered.");
        voters[voter] = true;
    }

    function _vote(uint contestantIndex) internal {
        require(voters[msg.sender], "You are not a registered voter.");
        require(contestantIndex < contestants.length, "Invalid contestant.");
        contestants[contestantIndex].voteCount += 1;
    }

    function _winningContestant() internal view returns (uint winningContestant_) {
        uint highestVoteCount = 0;
        for (uint i = 0; i < contestants.length; i++) {
            if (contestants[i].voteCount > highestVoteCount) {
                highestVoteCount = contestants[i].voteCount;
                winningContestant_ = i;
            }
        }
        assert(highestVoteCount > 0); // There should be at least one vote
    }

    function _endVoting() internal {
        if (contestants.length == 0) {
            revert("No contestants found.");
        }

        for (uint i = 0; i < contestants.length; i++) {
            delete contestants[i];
        }

        delete contestants;
    }
}

