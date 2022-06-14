// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "./VotingPoll.sol";

contract VotingFactory is AccessControl{

    bytes32 public constant ADMIN_CREATE_POLL = keccak256("ADMIN_CREATE_POLL");

    struct PollInfo {
        string title;
        address votingPoll;        
    }
    
    PollInfo[] public votingPollsList;
    
    event PollCreated(address deployer, string title, address addr);

    constructor () {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(ADMIN_CREATE_POLL, msg.sender);
    }
    
    function isAdmin(address account) public view virtual returns (bool) {
        return hasRole(ADMIN_CREATE_POLL, account);
    }

    modifier onlyAdmin() {
        require(isAdmin(msg.sender), "Unauthorized");
        _;
    }

    modifier onlyOwner() {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Not a owner");
        _;
    }

    function addAdmin(address account) public virtual onlyOwner {
        grantRole(ADMIN_CREATE_POLL, account);
    }

    function removeAdmin(address account) public virtual onlyOwner {
        revokeRole(ADMIN_CREATE_POLL, account);
    }

    function setOwnerRole(address _address) external onlyOwner {
        _grantRole(DEFAULT_ADMIN_ROLE, address(_address));
    }

    // function newVotingPoll(string memory _title, string[] memory _options) public onlyAdmin {
    function newVotingPoll(string memory _title, string[] memory _options) public {
        address pollAddress = address(new VotingPoll(msg.sender, _title, _options, votingPollsList.length));
        votingPollsList.push(
            PollInfo({
                title: _title,
                votingPoll: pollAddress                
            })
        );
        emit PollCreated(msg.sender, _title, pollAddress);        
    }

    function getPollsCount () external view returns(uint256) {
        return votingPollsList.length;
    }
}