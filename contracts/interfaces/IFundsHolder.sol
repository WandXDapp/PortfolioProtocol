pragma solidity ^0.4.19;
  
/**
 * @title IFundsHolder 
 * @dev An interface to define all funds related operations 
 * @author Dinesh
 */
contract IFundsHolder
{
    // Mapping of token addresses to mapping of account balances (token=0 means Ether)
    mapping (address => mapping (address => uint256)) public fundDeposits;  
    address[] public listTokens;
    
    // deposit event
    event Deposited(address _depositor, address _token, uint256 _amount, bytes32 _message);
    
    // withdraw event
    event withdrawn(address _depositor, address _token, uint256 _amount, bytes32 _message);
    
    // Desposit tokens and ether with portfolio
    function deposit(address _depositor) public payable;
    function depositTokens(address _token, uint _amount) public;
    
    // returns the balances of the tokens and ether
    function balanceOf(address _depositor) public view returns (uint256);
    function balanceOfToken(address _depositor, address _token) public view returns (uint256);
    
    // Withdraw tokens and ether from portfolio
    function withdraw(uint256 _mount) public;
    function withdrawTokens(address _token, uint _amount) public;
}
