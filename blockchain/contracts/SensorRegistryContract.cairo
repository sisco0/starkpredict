%lang starknet

@storage_var
func sensor_registry(sensor_id: felt) -> (sensor_type: felt, location: felt):
end

@storage_var
func location_sensors(location: felt, index: felt) -> (sensor_id: felt):
end

@storage_var
func location_sensor_count(location: felt) -> (count: felt):
end

@external
func register_sensor(sensor_id: felt, sensor_type: felt, location: felt):
    # Ensure the sensor is not already registered
    let (current_type, current_location) = sensor_registry.read(sensor_id)
    assert current_type = 0, 'Sensor already registered'
    
    # Register the sensor
    sensor_registry.write(sensor_id, sensor_type, location)
    
    # Update the location to sensor mapping
    let (count) = location_sensor_count.read(location)
    location_sensors.write(location, count, sensor_id)
    location_sensor_count.write(location, count + 1)
    return ()
end

@view
func get_sensors_by_location(location: felt) -> (sensor_ids_len: felt, sensor_ids: felt*):
    let (count) = location_sensor_count.read(location)
    let mut sensor_ids = alloc()
    let mut i = 0
    while i < count:
        let (sensor_id) = location_sensors.read(location, i)
        sensor_ids[i] = sensor_id
        i += 1
    end
    return (count, sensor_ids)
end

@view
func get_sensor_info(sensor_id: felt) -> (sensor_type: felt, location: felt):
    let (sensor_type, location) = sensor_registry.read(sensor_id)
    return (sensor_type, location)
end

