const { expect } = require("chai");
const { starknet } = require("hardhat");

describe("SensorRegistryContract", function () {
  let sensorRegistry;

  before(async function () {
    const SensorRegistry = await starknet.getContractFactory("SensorRegistryContract");
    sensorRegistry = await SensorRegistry.deploy();
  });

  it("should register a sensor", async function () {
    await sensorRegistry.register_sensor(1, 100, starknet.wallet.address);
    const sensorInfo = await sensorRegistry.get_sensor_info(1);
    expect(sensorInfo.sensor_type).to.equal(100);
    expect(sensorInfo.location).to.equal(starknet.wallet.address);
  });

  it("should get sensors by location", async function () {
    await sensorRegistry.register_sensor(1, 100, starknet.wallet.address);
    await sensorRegistry.register_sensor(2, 200, starknet.wallet.address);
    const sensors = await sensorRegistry.get_sensors_by_location(starknet.wallet.address);
    expect(sensors.sensor_ids_len).to.equal(2);
    expect(sensors.sensor_ids).to.include(1);
    expect(sensors.sensor_ids).to.include(2);
  });
});

