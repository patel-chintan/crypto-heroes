pragma solidity ^0.4.4;

contract AssetAccessControl {
 
    // This facet controls access control for Assets. There are two roles managed here:
    //
    //     - Admin: Register, transfer assets and do everything on contracts(pause/unpause/kill) 
    //
    //     - User: Can view only

    /// @dev Emited when contract is upgraded 
    event ContractUpgrade(address newContract);

    // The addresses of the accounts (or contracts) that can execute actions within each roles.
    address public adminAddress;
    address public userAddress;

    // @dev Keeps track whether the contract is paused. When that is true, most actions are blocked
    bool public paused = false;

    /// @dev Access modifier for Admin functionality
    modifier onlyAdmin() {
        require(msg.sender == adminAddress);
        _;
    }

    /// @dev Access modifier for User functionality
    modifier onlyUser() {
        require(msg.sender == userAddress);
        _;
    }

    function setAdmin(address _newAdmin) external onlyAdmin {
        require(_newAdmin != address(0));
        adminAddress = _newAdmin;
    }

    function setUser(address _newUser) external onlyAdmin {
        require(_newUser != address(0));
        userAddress = _newUser;
    }

    /*** Pausable functionality adapted from OpenZeppelin ***/

    /// @dev Modifier to allow actions only when the contract IS NOT paused
    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    /// @dev Modifier to allow actions only when the contract IS paused
    modifier whenPaused {
        require(paused);
        _;
    }

    /// @dev Called by Admin role to pause the contract. Used only when
    ///  a bug or exploit is detected and we need to limit damage.
    function pause() public onlyAdmin whenNotPaused returns (bool){
        paused = true;
        return paused;
    }

    /// @dev Unpauses the smart contract. Can only be called by the Admin
    /// @notice This is public rather than external so it can be called by
    ///  derived contracts.
    function unpause() public onlyAdmin whenPaused  returns (bool) {
        // can't unpause if contract was upgraded
        paused = false;
        return paused;
    }
}

