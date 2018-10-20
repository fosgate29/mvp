pragma solidity 0.4.24;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

import "./TreeCampaign.sol";

contract TreeHub is Ownable{
    
    address[] public treeCampaigns;
    mapping(address => bool) treeCampaignsExists;
      
    event NewTreeCampaign(address owner, address wallet, address treeCampaign);
    event Withdrawal(address sender, uint256 amount);
    
    function getCampaignCount()
        public
        constant
        returns(uint campaignCount)
    {
        return treeCampaigns.length;
    }
    
    function createCampaign(address _wallet)
        public
        payable
        returns(address treeCampaignContract)
    {
        require(msg.value == 1000000000000000 wei); //0.01 ether

        TreeCampaign trustedCampaign = new TreeCampaign(msg.sender, _wallet);
        treeCampaigns.push(trustedCampaign);
        treeCampaignsExists[trustedCampaign] = true;

        emit NewTreeCampaign(msg.sender, _wallet, trustedCampaign);
        
        return trustedCampaign;
    }

    function withdrawFunds()
        public
        onlyOwner        
        returns(bool)
    {
        uint256 amount = address(this).balance;
        owner.transfer(address(this).balance);
        
        emit Withdrawal(owner, amount);

        return true;
    }    


        
}