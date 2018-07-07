pragma solidity ^0.4.24;

contract ERC20 {

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);

    uint constant private MAX_UINT = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

    mapping (address => uint) private balances;
    mapping (address => mapping (address => uint)) private allowed;

    string constant public name = "ERC20 Token";
    string constant public symbol = "ERC20";
    uint constant public decimals = 18;
    uint constant public totalSupply = 10000 * (10 ** decimals);

    constructor() public {
        balances[msg.sender] = totalSupply;
        emit Transfer(0, msg.sender, totalSupply);
    }

    function balanceOf(address owner) external view returns (uint) {
        return balances[owner];
    }

    function allowance(address owner, address spender) external view returns (uint) {
        return allowed[owner][spender];
    }

    function transfer(address to, uint amount) external returns (bool) {
        require(to != address(this));
        require(to != 0);
        uint balanceOfMsgSender = balances[msg.sender];
        require(balanceOfMsgSender >= amount);
        balances[msg.sender] = balanceOfMsgSender - amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint amount) external returns (bool) {
        require(to != address(this));
        require(to != 0);
        uint allowedForMsgSender = allowed[from][msg.sender];
        require(allowedForMsgSender >= amount);
        if (allowedForMsgSender != MAX_UINT) {
            allowed[from][msg.sender] = allowedForMsgSender - amount;
        }
        uint balanceOfFrom = balances[from];
        require(balanceOfFrom >= amount);
        balances[from] = balanceOfFrom - amount;
        balances[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
}
