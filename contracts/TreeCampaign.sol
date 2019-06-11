pragma solidity 0.5.7;
 
import "./TreeCampaignVault.sol";


/// @title Base contract
contract TreeCampaign {

    TreeCampaignVault public trustedVault;

    constructor(address payable _wallet) public 
    {
        require(_wallet != address(0), "Wallet address should not be 0.");
        trustedVault = new TreeCampaignVault(_wallet);
    }

    //treeId is the hash of what3words of the tree
    //Example: water.ice.home
    function contribute(bytes32 _treeId) public payable
    {
        require(msg.value == 1 ether, "Contribution must be equal to 1 Ether");

        trustedVault.depositValue.value(msg.value)(msg.sender, _treeId);

    }

    //_treeLocation what3words location. Example water.car.home
    function createTreeId(string memory _treeLocation) public pure returns(bytes32)
    {
        return keccak256(abi.encodePacked(_treeLocation));
    }
}