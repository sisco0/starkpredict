%lang starknet

@storage_var
func audit_trail(index: felt) -> (user_address: felt, action: felt, timestamp: felt):
end

@storage_var
func audit_index() -> (index: felt):
end

@external
func log_action(user_address: felt, action: felt, timestamp: felt):
    let (index) = audit_index.read()
    audit_trail.write(index, user_address, action, timestamp)
    audit_index.write(index + 1)
    return ()
end

@view
func get_audit_trail() -> (trail: felt*):
    let (index) = audit_index.read()
    let mut trail = alloc()
    let mut i = 0
    while i < index:
        let (user_address, action, timestamp) = audit_trail.read(i)
        trail[i * 3] = user_address
        trail[i * 3 + 1] = action
        trail[i * 3 + 2] = timestamp
        i += 1
    end
    return (trail)
end

