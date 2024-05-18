// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract tc_avax {

    // Address of the contract deployer
    address payable public owner;

    struct Data {
        string date;
        string delivery_date;
        string product;
        string price;
        string code;
        string cel_number;
        int8 status;
        address wallet;
    }

    Data public data;

    event newData(string date,
                  string delivery_date,
                  string product,
                  string price,
                  string code,
                  string cel_number,
                  int8 status,
                  address wallet);

    // Modifier to check if caller is the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can withdraw");
        _;
    }

    // Modifier to check if enough AVAX is sent
    modifier costs(uint amount) {
        require(msg.value >= amount, "Not enough AVAX sent");
        _;
    }

    constructor() {
        // Set owner to the address that deployed the contract
        owner = payable(msg.sender);
    }

    function pushData(string memory _date,
                      string memory _delivery_date,
                      string memory _product,
                      string memory _price,
                      string memory _code,
                      string memory _cel_number,
                      int8 _status) public payable costs(1000000000000000) { // 0.001 AVAX in Wei
        
        data = Data(_date,
                    _delivery_date,
                    _product,
                    _price,
                    _code,
                    _cel_number,
                    _status,
                    msg.sender);

        emit newData(_date,
                    _delivery_date,
                    _product,
                    _price,
                    _code,
                    _cel_number,
                    _status,
                    msg.sender);
    }

    // Function to withdraw funds to the owner address
    function withdraw() public onlyOwner {
        // Check if there are funds in the contract
        uint balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        // Transfer the balance to the owner
        (bool success, ) = owner.call{value: balance}("");
        require(success, "Transfer failed");
    }

    // Function to get the contract's balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
