//A BurnableOpenPaymet is instantiated with one payer, and anyone can then enter to be the Recipient.
//The payer then can at any time choose to burn or release to the Recipient any amount of funds.

pragma solidity ^0.4.1;

contract BurnableOpenPayment {
    address public payer;
    address public recipient;
    address public burnAddress = 0xdead;
    
    modifier onlyPayer() {
        if (msg.sender != payer) throw;
        _;
    }
    
    modifier onlyWithRecipient() {
        if (recipient == 0) throw;
        _;
    }
    
    function () payable { }
    
    function BurnableOpenPayment() {
        payer = msg.sender;
    }
    
    function becomeRecipient() {
        if (recipient != 0) throw;
        recipient = msg.sender;
    }
    
    function getPayer() returns (address) {
        return payer;
    }
    
    function getRecipient() returns (address) {
        return recipient;
    }
    
    function burn(uint amount)
    onlyPayer()
    onlyWithRecipient()
    returns (bool)
    {
        return burnAddress.send(amount);
    }
    
    function release(uint amount)
    onlyPayer()
    onlyWithRecipient()
    returns (bool)
    {
        return recipient.send(amount);
    }
}