const { starknet } = require("hardhat");
const { expect } = require("chai");

describe("UserAccessControlContract", function () {
  let userAccessControl;
  let user1, user2;

  before(async function () {
    // Deploy the contract
    const UserAccessControlFactory = await starknet.getContractFactory("UserAccessControlContract");
    userAccessControl = await UserAccessControlFactory.deploy();

    // Get test accounts
    [user1, user2] = await starknet.getSigners();
  });

  it("should assign role to a user", async function () {
    // Assign role 1 to user1
    await userAccessControl.invoke("assign_role", { user_address: user1.address, role: 1 });

    // Verify role assignment
    const role = await userAccessControl.call("check_role", { user_address: user1.address, role: 1 });
    expect(role).to.equal(1);
  });

  it("should not confirm incorrect role", async function () {
    // Verify role mismatch
    const role = await userAccessControl.call("check_role", { user_address: user1.address, role: 2 });
    expect(role).to.equal(0);
  });

  it("should assign and verify role for another user", async function () {
    // Assign role 2 to user2
    await userAccessControl.invoke("assign_role", { user_address: user2.address, role: 2 });

    // Verify role assignment
    const role = await userAccessControl.call("check_role", { user_address: user2.address, role: 2 });
    expect(role).to.equal(1);
  });
});

