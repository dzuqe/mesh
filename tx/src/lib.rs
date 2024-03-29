use borsh::{self, BorshDeserialize, BorshSerialize};
use near_sdk::{env, near_bindgen};

#[global_allocator]
static ALLOC: wee_alloc::WeeAlloc = wee_alloc::WeeAlloc::INIT;

#[near_bindgen]
#[derive(Default, BorshDeserialize, BorshSerialize)]
pub struct CounterContract {
    val: i8,
}

#[near_bindgen]
impl CounterContract {
    #[init]
    pub fn new(&mut self) -> Self {
        self.val = 0;
        self
    }

    pub fn get_num(&self) -> i8 {
        return self.val;
    }

    pub fn increment(&mut self) {
        self.val = self.val + 1;
        let log_message = format!("Increased number to {}", self.val);
        env::log(log_message.as_bytes());
        after_counter_change();
    }

    pub fn decrement(&mut self) {
        self.val = self.val - 1;
        let log_message = format!("Decreased number to {}", self.val);
        env::log(log_message.as_bytes());
        after_counter_change();
    }
}

pub fn after_counter_change() {
    env::log("Make sure you don't overflow, my friend.".as_bytes());
}

#[cfg(test)]
mod tests {
    use super::*;
    use near_sdk::MockedBlockchain;
    use near_sdk::{testing_env, VMContext};

    fn get_context(input: Vec<u8>, is_view: bool) -> VMContext {
        VMContext {
            current_account_id: "alice_near".to_string(),
            signer_account_id: "robert_near".to_string(),
            signer_account_pk: vec![0, 1, 2],
            predecessor_account_id: "jane_near".to_string(),
            input,
            block_index: 0,
            block_timestamp: 0,
            epoch_height: 0,
            account_balance: 0,
            account_locked_balance: 0,
            storage_usage: 0,
            attached_deposit: 0,
            prepaid_gas: 10u64.pow(18),
            random_seed: vec![0, 1, 2],
            is_view,
            output_data_receivers: vec![],
        }
    }

    #[test]
    fn increment() {
        let context = get_context(vec![], false);
        testing_env!(context);
        let mut contract = CounterContract{ val: 0 };
        contract.increment();
        println!("Value after increment: {}", contract.get_num());
        assert_eq!(1, contract.get_num());
    }

    #[test]
    fn decrement() {
        let context = get_context(vec![], false);
        testing_env!(context);
        let mut contract = CounterContract{ val: 0 };
        contract.decrement();
        println!("Value after decrement: {}", contract.get_num());
        assert_eq!(-1, contract.get_num());
    }
}
