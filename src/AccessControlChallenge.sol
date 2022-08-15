// SDPX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

import "openzeppelin-contracts/contracts/access/AccessControl.sol";

contract AccessControlChallenge is AccessControl{
    bytes32 ROLE_ADMIN=keccak256("ROLE_ADMIN");
    bytes32 ROLE_WRITER=keccak256("ROLE_WRITER");

    constructor(){
        _grantRole(ROLE_ADMIN, msg.sender);
    }


    uint256 number;

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public onlyWriter {
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }

    function addWriter(address _writer) public onlyAdmin{
        _grantRole(ROLE_WRITER, _writer);
    }

    function removeWriter(address _writer) public onlyAdmin{
        _revokeRole(ROLE_WRITER, _writer);
    }

    modifier onlyAdmin(){
        require(hasRole(ROLE_ADMIN, msg.sender), "You must be ADMIN to execute this function");
        _;
    }

    modifier onlyWriter(){
        require(hasRole(ROLE_WRITER, msg.sender), "You must be WRITER to execute this function");
        _;
    }
}
