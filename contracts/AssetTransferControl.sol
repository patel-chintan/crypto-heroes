pragma solidity ^0.4.4;
import "./AssetOwnership.sol";

contract AssetTransferControl is AssetOwnership {

    // Set in case the core contract is broken and an upgrade is required
    address public newContractAddress;

  function AssetTransferControl() public {
    // constructor
        // Starts paused.
        paused = true;

        // the creator of the contract is the initial admin
        adminAddress = msg.sender;
  }

    /// @dev Used to mark the smart contract as upgraded, in case there is a serious
    ///  breaking bug. This method does nothing but keep track of the new contract and
    ///  emit a message indicating that the new address is set. 
    /// @param _v2Address new address
    function setNewAddress(address _v2Address) external onlyAdmin whenPaused {
        // See README.md for updgrade plan
        newContractAddress = _v2Address;
        ContractUpgrade(_v2Address);
    }

    /// @notice No tipping!
    /// @dev Reject all Ether from being sent here, unless it's from one of the
    ///  two auction contracts. (Hopefully, we can prevent user accidents.)
    function() external payable {
        //to do: enhance boundary conditions
    }

    /// @notice Returns all the relevant information about a specific Asset.
    /// @param _id The ID of the asset of interest.
    function getAsset(uint256 _id)
        external
        view
        returns (
        uint32 _assetExternalId,
        bytes32  _assetName
    ) {
        Asset storage asset = assets[_id];
        _assetExternalId = asset.assetExternalId;
        _assetName = asset.assetName;
    }

    /// @dev Override unpause so it requires all external contract addresses
    ///  to be set before contract can be unpaused. Also, we can't have
    ///  newContractAddress set either, because then the contract was upgraded.
    /// @notice This is public rather than external so we can call super.unpause
    ///  without using an expensive CALL.
    function unpause() public onlyAdmin whenPaused returns (bool) {
        require(newContractAddress == address(0));

        // Actually unpause the contract.
        return super.unpause();
    }

    // @dev Allows the CFO to capture the balance available to the contract.
    function withdrawBalance() external onlyAdmin {
        uint256 balance = this.balance;
        adminAddress.send(balance);
    }

}
