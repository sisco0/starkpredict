#[starknet::interface]
trait IUserAccessControlContract<TContractState> {
    fn assign_role(ref self: TContractState, user_address: felt252, role: felt252);
    fn check_role(self: @TContractState, user_address: felt252, role: felt252) -> felt252;
}

#[starknet::contract]
mod UserAccessControlContract {
    #[storage]
    struct Storage {
        user_roles: LegacyMap<felt252, felt252>,
    }

    #[abi(embed_v0)]
    impl UserAccessControlContract of super::IUserAccessControlContract<ContractState> {
        fn assign_role(ref self: ContractState, user_address: felt252, role: felt252) {
            self.user_roles.write(user_address, role);
        }

        fn check_role(self: @ContractState, user_address: felt252, role: felt252) -> felt252 {
            let stored_role = self.user_roles.read(user_address);
            if stored_role == role {
                return 1;
            } else {
                return 0;
            }
        }
    }
}

