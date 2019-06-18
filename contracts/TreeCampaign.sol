pragma solidity 0.5.7;
 
import "./TreeCampaignVault.sol";


/// @title Base contract
contract TreeCampaign {

    TreeCampaignVault public trustedVault;

    event LogVaultCreated(address campaignCreator, address vaultOwnerWallet, address trustedVaultCreated);
    event LogContributionSent(address contributor, uint256 value, string treeLocation);

    constructor(address payable _wallet) public 
    {
        require(_wallet != address(0), "Wallet address should not be 0.");
        trustedVault = new TreeCampaignVault(_wallet);
        emit LogVaultCreated(msg.sender, _wallet, trustedVaultCreated);
    }

    //treeId is the hash of what3words of the tree
    //Example: water.ice.home
    function contribute(string _treeLocation) public payable
    {
        require(msg.value == 1 ether, "Contribution must be equal to 1 Ether");

        trustedVault.depositValue.value(msg.value)(msg.sender, _treeLocation);

        emit LogContributionSent(msg.sender, msg.value, _treeLocation);

    }
}