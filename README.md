# ErrorFunc


# Voting Smart Contract

This is a smart contract for a simple voting system on the Ethereum blockchain. The contract allows the chairperson to register voters, cast votes, and determine the winning contestant. The contract uses Solidity and is designed to run on the Ethereum Virtual Machine (EVM).

## Contract Overview

### Contract Structure

- **Structs**
  - `Contestant`: Represents a contestant with a name and vote count.

- **State Variables**
  - `chairperson`: The address of the chairperson who deploys the contract.
  - `voters`: A mapping of voter addresses to their registration status.
  - `contestants`: An array of `Contestant` structs representing the contestants.

- **Modifiers**
  - `onlyChairperson`: Ensures that only the chairperson can call certain functions.

- **Constructor**
  - Initializes the contract with an array of contestant names.

- **Functions**
  - `registerVoter(address voter)`: Registers a new voter.
  - `vote(uint contestantIndex)`: Casts a vote for a contestant.
  - `winningContestant() view returns (uint)`: Returns the index of the winning contestant.
  - `endVoting()`: Ends the voting process and deletes all contestants.
