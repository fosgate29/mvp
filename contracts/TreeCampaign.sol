pragma solidity 0.4.24;
 
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

import "./TreeCampaignVault.sol";


/// @title Base contract
contract TreeCampaign is Ownable {

    TreeCampaignVault public trustedVault;

    constructor(address _owner, address _wallet) public 
    {
        require(_wallet != address(0), "Wallet address should not be 0.");
        owner = _owner;
        trustedVault = new TreeCampaignVault(_wallet);
    }

    //treeId is the hash of what3words of the tree
    function contribute(bytes32 _treeId) public payable
    {
        require(msg.value == 1 ether);

        trustedVault.depositValue.value(msg.value)(msg.sender, _treeId);

    }

    //_treeLocation what3words location. Example water.car.home
    function createTreeId(string _treeLocation) public pure returns(bytes32)
    {
        return keccak256(abi.encodePacked(_treeLocation));
    }
}