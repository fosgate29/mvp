pragma solidity 0.4.24;
 
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./Vault.sol";

/// @title Base contract
contract TreeSale is Ownable {

	Vault public trustedVault;

	mapping(bytes32 => bool) public trees;

	constructor(
        address _wallet
    ) 
        public 
    {
        require(_wallet != address(0), "Wallet address should not be 0.");
        trustedVault = new Vault(_wallet);
    }

    //treeId is the hash of what3words of the tree
	function contribute(bytes32 _treeId) public payable
	{
		require(msg.value  == 1 ether);
		require(trees[_treeId] == false);
		trees[_treeId] = true; //is sold

		trustedVault.depositValue.value(msg.value)(msg.sender, _treeId);

	}

}