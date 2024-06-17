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
func verify_data_integrity(sensor_id: felt, date: felt, data_hash: felt) -> (valid: felt):
    let (stored_hash) = daily_hashes.read(sensor_id, date)
    if stored_hash == data_hash:
        return (1)
    else:
        return (0)
    end
end

