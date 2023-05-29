# Example beginners eth solidity contracts
Several beginner contracts to play with solidity

# To run contracts
[start Remix IDE](https://remix.ethereum.org/)
Paste contract, compile, deploy and start calling functions

## TODO list
In file `TODO.sol` is a basic TODO implementation.
`add(string)` will add new item
`markDone(uint)` will make that id as done
`list()` returns array of all TODO items

## Simple Lotto
In file `lotto.sol` you will find simple lottery contract.
Players may buy tickets (or bet). One player can buy multiple tickets.
`bet()` call this with exactly 1 ether value to make bets (or buy tickets).
The fixed bet amount is in variable `uint32 public constant BET_AMOUNT_ETHER = 1;`
When the betting phase is over (only) the owner of the contract can call
`playAndPayWinner()`, money will be sent to the randomly selected winning ticket/entry.
`uint public constant RTP = 95; // casino takes 5%` this variable controls what is casino's cut.
RTP of 95 means casino will return 95% of bets to players
`getPlayers()` will return the addresses of all participating players


## vote.sol - example voting
This is simple voting contract, no extra features.
A fixed number of candidates are set in contract `constructor()`.
Then users can call `vote(id)`. Each address can vote only once and the voting must not have ended.
Once the voting time is over call `endVoting()`. This will set `ended` to true and prevent future voting.
`candidatesCount` number of candidates
`getWinner()` call will return current winner's name. 2 or more names will bn returned in case of tie
`list()` return the Candidate objects for each candidate. It has id,name,true(exists),voteCount
