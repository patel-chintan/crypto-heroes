pragma solidity ^0.4.4;

/// @title The external contract that is responsible for generating metadata for the ERC721 token,
///  it has one function that will return the data as bytes.
contract ERC721Metadata {
    /// @dev Given a token Id, returns a byte array that is supposed to be converted into string.
    function getMetadata(uint256 _tokenId, string) public view returns (bytes32[4] buffer, uint256 count) {
        if (_tokenId == 1) {
            buffer[0] = "GOLD";
            count = 4;
        } else if (_tokenId == 2) {
            buffer[0] = "DIAMOND";
            count = 7;
        } else if (_tokenId == 3) {
            buffer[0] = "Not Defined";
            count = 11;
        }
    }
}
