// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract VotingPoll {

    address private owner;
    string public votingTitle;
    string[] public options;
    uint256 public pollId;    
    mapping(address => uint256) userVoted;
    mapping(uint256 => uint256) votingResult;

    constructor (address _creater, string memory _title, string[] memory _options, uint256 _id) {
        owner = _creater;
        votingTitle = _title;
        options = _options;        
        pollId = _id;
    }

    function getOwner() external view returns(address) {
        return owner;
    }

    function getTitle() external view returns(string memory) {
        return votingTitle;
    }

    function getOptions() external view returns(string[] memory) {
        return options;
    }

    function getOptionCounts() external view returns(uint256) {
        return options.length;
    }

    function getResult(uint256 _optionId) external view returns(uint256) {
        return votingResult[_optionId];
    }

    function getUserVoted(address _from) external view returns(uint256) {
        return userVoted[_from];
    }    

    function voting(uint _optionId) external {
        require(userVoted[msg.sender] == 0, "Can't join twice in one poll");        
        userVoted[msg.sender] = _optionId + 1;
        votingResult[_optionId]++;
    }
}