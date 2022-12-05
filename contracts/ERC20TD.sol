pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";

contract ERC20TD is ERC20, IExerciceSolution{

//mapping(address => uint256) private _balances;
mapping(address => mapping(address => uint256)) private _allowances;
mapping(address=>bool) private listing;

constructor() public ERC20("XxPaoligxX", "PAO") {
        
        uint _supply=958636845000000000000000000;
        //_balances[0x3cb31a62Cdfb388c6e18227951eD5c7c158d4bD0]=0;
        //_mint(msg.sender, _supply);
        listing[msg.sender]=true;
    }

  function symbol() public view override(ERC20, IExerciceSolution) returns (string memory){
    return "RVRA-";
  }

  function allowance(address owner, address spender) public view virtual override(ERC20, IERC20) returns (uint256) {
    return _allowances[owner][spender];
  } 

  function approve(address spender, uint256 amount) public virtual override(ERC20, IERC20) returns (bool) {
    address owner = _msgSender();
    _approve(owner, spender, amount);
    return true;
  }
  /*function balanceOf(address owner) public view override(ERC20, IERC20) returns (uint256){
    return _balances[owner];
  }*/
    
  function getToken() external override returns (bool){
    require(listing[msg.sender]);
    _mint(msg.sender,2);

    return true;
  }

  function buyToken() external payable override returns (bool){ 
    //_balances[address(0x7C5629d850eCD1E640b1572bC0d4ac5210b38FA5)]+=msg.value;  
    if(this.isCustomerWhiteListed(msg.sender)){
      _mint(msg.sender, msg.value*this.customerTierLevel(msg.sender));
      return true;
    }
    else{
      return false;
    }
  }

  function isCustomerWhiteListed(address customerAddress) external override returns (bool){
    if(listing[msg.sender]=true){
      return true;
    }
    else{
      return false;
    }
  }

  function customerTierLevel(address customerAddress) external override returns (uint256){
    return 2;
  }
}