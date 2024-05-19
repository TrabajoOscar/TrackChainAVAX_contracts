// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

contract tc_avax {

    // Address of the contract deployer
    address payable public owner;

    struct Data {
        string ipfs_url;
        uint256 price;
        int8 status;
        address wallet;
    }

    Data public data;

    event newData(string ipfs_url,
                  uint256 price,
                  int8 status,
                  address wallet);

    // Modifier to check if caller is the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can withdraw");
        _;
    }

    constructor() {
        // Set owner to the address that deployed the contract
        owner = payable(msg.sender);
    }

    // Chage state in log
    function pushData(string memory _ipfs_url,
                      uint256 _price,  
                      int8 _status) public payable { 
        
        data = Data(_ipfs_url,
                    _price,
                    _status,
                    msg.sender);

        emit newData(_ipfs_url,
                    _price,
                    _status, 
                    msg.sender);
    }

    // Function to withdraw funds to the owner address
    function withdraw() public onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");
        
        (bool success, ) = owner.call{value: balance}("");
        require(success, "Transfer failed");
    }

    // Function to get the contract's balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}