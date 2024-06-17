%lang starknet

@storage_var
func predictions(sensor_id: felt, date: felt) -> (maintenance_required: felt, maintenance_date: felt):
end

@external
func record_prediction(sensor_id: felt, date: felt, maintenance_required: felt):
    predictions.write(sensor_id, date, maintenance_required, 0)
    return ()
end

@external
func schedule_maintenance(sensor_id: felt, maintenance_date: felt):
    let (maintenance_required, _) = predictions.read(sensor_id, date)
    assert maintenance_required != 0, 'Maintenance not required'
    predictions.write(sensor_id, date, maintenance_required, maintenance_date)
    return ()
end

