%lang starknet

@storage_var
func maintenance_logs(sensor_id: felt, maintenance_id: felt) -> (timestamp: felt, action_taken: felt, technician_id: felt):
end

@external
func log_maintenance(maintenance_id: felt, sensor_id: felt, timestamp: felt, action_taken: felt, technician_id: felt):
    maintenance_logs.write(sensor_id, maintenance_id, timestamp, action_taken, technician_id)
    return ()
end

@view
func get_maintenance_log(sensor_id: felt, maintenance_id: felt) -> (timestamp: felt, action_taken: felt, technician_id: felt):
    let (timestamp, action_taken, technician_id) = maintenance_logs.read(sensor_id, maintenance_id)
    return (timestamp, action_taken, technician_id)
end

