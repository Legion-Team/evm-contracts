// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Test, console2, Vm} from "forge-std/Test.sol";

import {ILegionAddressRegistry} from "../src/interfaces/ILegionAddressRegistry.sol";
import {LegionAddressRegistry} from "../src/LegionAddressRegistry.sol";

contract LegionAddressRegistryTest is Test {
    LegionAddressRegistry public addressRegistry;

    address legionAdmin = address(0x01);
    address nonOwner = address(0x02);

    address registry = address(0x03);

    function setUp() public {
        addressRegistry = new LegionAddressRegistry(legionAdmin);
    }

    /**
     * @dev Test Case: Verify that the LegionAddress registry contract initializes correctly with the correct owner
     */
    function test_transferOwnership_successfullySetsTheCorrectOwner() public {
        // Assert
        assertEq(addressRegistry.owner(), legionAdmin);
    }

    /**
     * @dev Test Case: Successfully updates address if called by owner
     */
    function test_setLegionAddress_successfullyUpdatesAddressIfCalledByOwner() public {
        // Arrange
        vm.prank(legionAdmin);

        // Assert
        vm.expectEmit();
        emit ILegionAddressRegistry.LegionAddressSet(bytes32("LEGION_REGISTRY"), address(0), registry);

        // Act
        addressRegistry.setLegionAddress(bytes32("LEGION_REGISTRY"), registry);
    }

    /**
     * @dev Test Case: Attempt to update address by non-owner
     */
    function test_setLegionAddress_revertsIfNotCalledByOwner() public {
        // Arrange
        vm.prank(nonOwner);

        // Assert
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, nonOwner));

        // Act
        addressRegistry.setLegionAddress(bytes32("LEGION_REGISTRY"), registry);
    }

    /**
     * @dev Test Case: Return correct address for set identifier
     */
    function test_getLegionAddress_successfullyReturnsLegionAddress() public {
        // Arrange
        vm.prank(legionAdmin);
        addressRegistry.setLegionAddress(bytes32("LEGION_ADMIN"), legionAdmin);

        // Act
        address _legionAdmin = addressRegistry.getLegionAddress(bytes32("LEGION_ADMIN"));

        // Assert
        assertEq(_legionAdmin, legionAdmin);
    }

    /**
     * @dev Test Case: Return zero address in case an address is not set
     */
    function test_getLegionAddress_successfullyReturnsZeroAddressIfNotSet() public {
        // Arrange
        vm.prank(legionAdmin);

        // Act
        address _legionAdmin = addressRegistry.getLegionAddress(bytes32("LEGION_ADMIN"));

        // Assert
        assertEq(_legionAdmin, address(0));
    }
}
