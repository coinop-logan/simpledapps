//A BurnablePaymet is instantiated with msg.sender as the payer, and a specified recipient.
//The payment can be instantiated with funds, and can be added to later by anyone.
//The payer can never directly recover the payment.
//The payer then can at any time choose to burn or release to the recipient any amount of funds.

pragma solidity ^0.4.1;

contract BurnableOpenPayment {
    address public payer;
    address public recipient;
    address public burnAddress = 0xdead;
    uint public thresholdCommit;
    
    modifier onlyPayer() {
        if (msg.sender != payer) throw;
        _;
    }
    
    //function () payable { } disabled for more predictable behavior, in case some script is watching this contract's balance
    
    function BurnableOpenPayment(uint _thresholdCommit) payable {
        payer = msg.sender;
        thresholdCommit = _thresholdCommit;
    }
    
    function getPayer() returns (address) {
        return payer;
    }
    
    function getRecipient() returns (address) {
        return recipient;
    }
    
    function getThresholdCommit() returns (uint) {
        return thresholdCommit;
    }
    
    function commit()
    returns (bool)
    {
        if (msg.value < thresholdCommit) throw;
        recipient = msg.sender;
    }
    
    function burn(uint amount)
    onlyPayer()
    returns (bool)
    {
        return burnAddress.send(amount);
    }
    
    function release(uint amount)
    onlyPayer()
    returns (bool)
    {
        return recipient.send(amount);
    }
}