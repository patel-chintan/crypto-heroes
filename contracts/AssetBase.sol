pragma solidity ^0.4.4;
import "./AssetAccessControl.sol";

contract AssetBase is AssetAccessControl {
  struct Asset {
    uint32 assetExternalId;
    bytes32  assetName;
  }

  /// @dev An array containing the Asset struct for all assets in existence. The ID
  ///  of each asset is an index into this array. 
  Asset[] assets;
  /// @dev A mapping from asset IDs to the address that owns them. All assets have
  ///  some valid owner address, the manufacturer/producer being the default owner
  mapping (uint256 => address) public assetIndexToOwner;
  // @dev A mapping from owner address to count of tokens that address owns.
  //  Used internally inside balanceOf() to resolve ownership count.
  mapping (address => uint256) ownershipTokenCount;
  /// @dev A mapping from assetIDs to an address that has been approved to call
  ///  transferFrom(). Each asset can only have one approved address for transfer
  ///  at any time. A zero value means no approval is outstanding.
  mapping (uint256 => address) public assetIndexToApproved;

  /// @dev The first time reg event is fired whenever a new asset comes into existence. 
  event RegisteredFirstTime(address owner, uint256 assetId);

  /// @dev Transfer event as defined in current draft of ERC721. Emitted every time an asset
  ///  ownership is assigned/transferred
  event Transfer(address from, address to, uint256 tokenId);

  function AssetBase() public {
    // constructor
  }

  function _transfer(address _from, address _to, uint256 _tokenId) internal {
      // Since the number of kittens is capped to 2^32 we can't overflow this
      ownershipTokenCount[_to]++;
      // transfer ownership
      assetIndexToOwner[_tokenId] = _to;
      // When creating new kittens _from is 0x0, but we can't account that address.
      if (_from != address(0)) {
          ownershipTokenCount[_from]--;
          // clear any previously approved ownership exchange
          delete assetIndexToApproved[_tokenId];
      }
      // Emit the transfer event.
      Transfer(_from, _to, _tokenId);
  }

  function _createAsset(address _owner, uint32 _assetExternalId, bytes32 _assetName) internal returns (uint) {

    Asset memory _asset = Asset({
            assetExternalId: _assetExternalId,
            assetName: _assetName
        });
        uint256 newAssetId = assets.push(_asset) - 1;

        // emit the registration event
        RegisteredFirstTime(_owner,newAssetId);
        // This will assign ownership, and also emit the Transfer event as
        // per ERC721 draft
        _transfer(0, _owner, newAssetId);

        return newAssetId;
    }

}
