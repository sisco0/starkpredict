%lang starknet

@storage_var
func alert_thresholds(sensor_id: felt) -> (threshold: felt):
end

@external
func set_alert_threshold(sensor_id: felt, threshold: felt):
    alert_thresholds.write(sensor_id, threshold)
    return ()
end

@external
func trigger_alert(sensor_id: felt, timestamp: felt):
    let (threshold) = alert_thresholds.read(sensor_id)
    # Assume a function get_sensor_data exists that retrieves the latest sensor data
    let (sensor_data) = get_sensor_data(sensor_id)
    if sensor_data > threshold:
        # Logic to handle the alert, e.g., emit an event or take an action
        emit Alert(sensor_id, timestamp)
    end
    return ()
end

