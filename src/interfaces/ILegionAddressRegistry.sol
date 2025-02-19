// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

/**
 * ██      ███████  ██████  ██  ██████  ███    ██
 * ██      ██      ██       ██ ██    ██ ████   ██
 * ██      █████   ██   ███ ██ ██    ██ ██ ██  ██
 * ██      ██      ██    ██ ██ ██    ██ ██  ██ ██
 * ███████ ███████  ██████  ██  ██████  ██   ████
 *
 * If you find a bug, please contact security(at)legion.cc
 * We will pay a fair bounty for any issue that puts user's funds at risk.
 *
 */
interface ILegionAddressRegistry {
    /**
     * @notice This event is emitted when a new Legion address is set or updated.
     *
     * @param id The unique identifier of the address.
     * @param previousAddress The previous address before the update.
     * @param updatedAddress The updated address.
     */
    event LegionAddressSet(bytes32 id, address previousAddress, address updatedAddress);

    /**
     * @notice Sets a Legion address.
     *
     * @param id The unique identifier of the address.
     * @param updatedAddress The updated address.
     */
    function setLegionAddress(bytes32 id, address updatedAddress) external;

    /**
     * @notice Gets a Legion address.
     *
     * @param id The unique identifier of the address.
     *
     * @return The requested address.
     */
    function getLegionAddress(bytes32 id) external view returns (address);
}
