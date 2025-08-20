// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract OrganDonation {
    struct Donor {
        string name;
        uint age;
        string bloodGroup;
        string[] organs;
        bool registered;
    }

    struct Recipient {
        string name;
        uint age;
        string bloodGroup;
        string requiredOrgan;
        bool registered;
    }

    mapping(address => Donor) public donors;
    mapping(address => Recipient) public recipients;
    address public admin;

    event DonorRegistered(address donor);
    event RecipientRegistered(address recipient);
    event OrganMatched(address donor, address recipient, string organ);

    constructor() {
        admin = msg.sender;
    }

    function registerDonor(string memory _name, uint _age, string memory _bloodGroup, string[] memory _organs) public {
        donors[msg.sender] = Donor(_name, _age, _bloodGroup, _organs, true);
        emit DonorRegistered(msg.sender);
    }

    function registerRecipient(string memory _name, uint _age, string memory _bloodGroup, string memory _requiredOrgan) public {
        recipients[msg.sender] = Recipient(_name, _age, _bloodGroup, _requiredOrgan, true);
        emit RecipientRegistered(msg.sender);
    }

    function matchOrgan(address _donor, address _recipient, string memory _organ) public {
        require(msg.sender == admin, "Only admin can match");
        require(donors[_donor].registered, "Donor not registered");
        require(recipients[_recipient].registered, "Recipient not registered");
        emit OrganMatched(_donor, _recipient, _organ);
    }
}
