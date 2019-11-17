pragma solidity ^0.4.24;

contract Currency {
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowances;
    function createCurrency(uint256 amt) public {
        require(amt <= currencyLeft);
        balances[msg.sender] += amt;
        currencyLeft -= amt;
    }
    
    uint total = 1000;
    uint currencyLeft = 1000;
    function totalSupply() public view returns (uint total) {
        return total;
    }
    
    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }
    
    function transfer(address reciever, uint numTokens) public returns (bool) {
        // if(balances[msg.sender] < numTokens) {
        //     return false;
        // }
        // else {
        //     balances[reciever] += numTokens;
        //     balances[msg.sender] -= numTokens;
        //     return true;
        // }
        
        //if it fails the require then you get your gas back so it's like a warranty
        require (balances[msg.sender] > numTokens);
        balances[msg.sender] -= numTokens;
        balances[reciever] += numTokens;
        emit Transfer(msg.sender, reciever, numTokens);
        return true;
    }
    
    
    function approve(address delegate, uint numTokens) public view returns (bool) {
        allowances[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }
    
    function allowance(address owner, address delegate) public view returns (uint) {
        return allowances[owner][delegate];
    }
    
    function transferFrom(address owner, address buyer, uint numTokens) public view returns(bool) {
        require(allowances[owner][buyer] >= numTokens);
        require(numTokens <= balances[owner]);
        allowances[owner][buyer] -= numTokens;
        balances[owner] -= numTokens;
        balances[buyer] += numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 amount);
    
    event Approval(address indexed _owner, address indexed _approved, uint256 amount);
}