var AssetTransferControlContract = artifacts.require("./AssetTransferControl.sol");

/**
 * 
Desired:
As an Admin I can register Company with name and description
As a Company I can register an Asset with id and name
As a Company I can transfer an Asset to another company
Optional:
Implement ERC 721 non-fungible asset
Confidentiality solution: nobody knows who the owner, but the owner can prove to anybody.
Payment during transfer: crypto or fiat.
Client side (can be in browser or in terminal)
As a user I can see list of all companies
As a user I can see list of company’s assets with ownership history
As a user I can see list of all assets with current owner company
As a user I can do full-text search over companies and assets.
 */
contract('AssetTransferControl', function(accounts) {

  it("should assert true", function(done) {
    var assetTransferControl;
    return AssetTransferControlContract.deployed().then(function(instance){
      assetTransferControl = instance;
      return instance.unpause().then(function(result){
        assert.isTrue(result);
      });
    });
  
      //return assetTransferControl.unpause().then(function(result){
        //assert.isTrue(assetTransferControl.unpause());
        //done();
      });
    });
  //});
//});
//1. register admin
//2. register user
//3. register owner
//4. register non-owner
//5. admin registers asset to owner. Asset is ERC721 token.
//6. admin can transfer asset from owner to non-owner

