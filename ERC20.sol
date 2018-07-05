pragma solidity ^0.4.24;

contract ERC20 {

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);

    uint private MAX_UINT = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

    mapping (address => uint) private balances;
    mapping (address => mapping (address => uint)) private allowed;

    string public name = "ERC20 Token";
    string public symbol = "ERC20";
    uint public decimals = 18;
    uint public totalSupply = 10000 * (10 ** decimals);

    constructor(address owner) public {
        balances[owner] = totalSupply;
        emit Transfer(0, owner, totalSupply);
    }

    function balanceOf(address owner) external view returns (uint) {
        return balances[owner];
    }

    function allowance(address owner, address spender) external view returns (uint) {
        return allowed[owner][spender];
    }

    function transfer(address to, uint amount) external returns (bool) {
        require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint amount) external returns (bool) {
        uint allowedForMsgSender = allowed[from][msg.sender];
        require(allowedForMsgSender >= amount);
        require(balances[from] >= amount);
        balances[from] -= amount;
        balances[to] += amount;
        if (allowedForMsgSender != MAX_UINT) {
            allowed[from][msg.sender] -= amount;
        }
        emit Transfer(from, to, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
}
