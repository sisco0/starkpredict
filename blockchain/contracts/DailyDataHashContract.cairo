%lang starknet

@storage_var
func daily_hashes(sensor_id: felt, date: felt) -> (data_hash: felt):
end

@external
func store_daily_hash(sensor_id: felt, date: felt, data_hash: felt):
    daily_hashes.write(sensor_id, date, data_hash)
    return ()
end

@view
func get_daily_hash(sensor_id: felt, date: felt) -> (data_hash: felt):
    let (data_hash) = daily_hashes.read(sensor_id, date)
    return (data_hash)
end

