pragma solidity ^0.4.19;
  
/**
 * @title IPortfolio 
 * @dev An interface to basic portfolio functions 
 *      - Maker publishes the portfolio, buyer buys it as whole
 * @author Dinesh
 */
contract IPortfolio
{
    // struct that contains current info
    struct Portfolio {
        address maker;
        address currentOwnerOrSeller; 
        uint256 valueInPrefTokens; 
        address buyer;
    }
    
    // current state structure data of the portfolio
    Portfolio public currentPortfolio; 
    
    // Current published orders hash
    bytes32 public currentOrderHash;
    
    // Stores all the hashes through the multiple levels trades
    bytes32[] public listOrderHashes; 
    
    // Mapping of portfolio assets
    mapping (address => uint256) public assets;
    address[] public listAssets;
   
    // after which block this portfolio expires
    uint256 public expiresAt;
    
    // target tokens seller or owner is ready to accept, if seller wanted ether as 
    // preferred currency, then this value can be 0x0
    address public preferredTokens;
    
    // event for portfolio publishment
    event PortfolioPublsihed(address _ownerOrSeller, uint256 _amount, address _preferredTokens, bytes32 _message);
    
    // event for all portfolio operations
    event PortfolioEvents(address _ownerOrSeller, bytes32 _message); 
    
    // portfolio buy event
    event PortfolioBought(address _ownerOrSeller, address _buyer, uint256 _amount, bytes32 _message );
   
    //  registers the assets with the portfolio contract
    function addOrUpdateAssets(address[] _assets, uint256[] _volumes) private;
   
    // enables to portfolio to be traded, only owner can call this method
    // once publishes there will not be any changes to portfolio is possible
    function publish() public;
    
    // makes the portfolio non-tradable permanently, and only current owner can call this
    function killPortfolio() public;
    
    // full buy function
    function buy() public payable;
    function buyWithPrefToken(uint256 _amount) public;
    
    // transfers the assets between 2 accounts
    function moveAssets(address _from, address _to) internal;
    
    // withdraws all the portfolio assets from the contract and closes the contract
    function liquidate() public;
}
