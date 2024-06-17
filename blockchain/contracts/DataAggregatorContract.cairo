%lang starknet

@storage_var
func aggregated_data(sensor_id: felt, start_time: felt, end_time: felt) -> (data_hash: felt):
end

@external
func aggregate_data(sensor_id: felt, timestamps: felt*, data_hashes: felt*):
    # Logic to aggregate data hashes, e.g., by concatenating and hashing them together
    let data_hash = hash_concatenated_data(data_hashes)
    aggregated_data.write(sensor_id, start_time, end_time, data_hash)
    return ()
end

@view
func get_aggregated_data(sensor_id: felt, start_time: felt, end_time: felt) -> (data_hash: felt):
    let (data_hash) = aggregated_data.read(sensor_id, start_time, end_time)
    return (data_hash)
end

