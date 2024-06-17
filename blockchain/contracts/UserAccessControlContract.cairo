%lang starknet

@storage_var
func user_roles(user_address: felt) -> (role: felt):
end

@external
func assign_role(user_address: felt, role: felt):
    user_roles.write(user_address, role)
    return ()
end

@view
func check_role(user_address: felt, role: felt) -> (has_role: felt):
    let (stored_role) = user_roles.read(user_address)
    if stored_role == role:
        return (1)
    else:
        return (0)
    end
end

