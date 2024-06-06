// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

struct TransferRequest {
    address dispatcher;
    address sender;
    uint256 deadline;
    uint256 nonce;
    uint256 amount;
    address token;
    bytes32 secretHash;
}

/// @notice helpers for handling TransferRequest
library TransferRequestLib {
    bytes internal constant TRANSFER_REQUEST_TYPE = abi.encodePacked(
        "TransferRequest(",
        "address dispatcher,",
        "address sender,",
        "uint256 deadline,",
        "uint256 nonce,",
        "uint256 amount,",
        "address token,",
        "bytes32 secretHash)"
    );

    /// @dev Note that sub-structs have to be defined in alphabetical order in the EIP-712 spec
    bytes32 internal constant TRANSFER_REQUEST_TYPE_HASH = keccak256(TRANSFER_REQUEST_TYPE);

    string internal constant TOKEN_PERMISSIONS_TYPE = "TokenPermissions(address token,uint256 amount)";
    string internal constant PERMIT2_ORDER_TYPE = string(
        abi.encodePacked("TransferRequest witness)", TOKEN_PERMISSIONS_TYPE, TRANSFER_REQUEST_TYPE)
    );

    /// @notice hash the given order
    /// @param order the order to hash
    /// @return the eip-712 order hash
    function hash(PerpOrder memory order) internal pure returns (bytes32) {
        return keccak256(
            abi.encode(
                TRANSFER_REQUEST_TYPE_HASH,
                order.dispatcher,
                order.sender,
                order.deadline,
                order.nonce,
                order.amount,
                order.token,
                order.secretHash
            )
        );
    }
}