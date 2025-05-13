module katerith::calculator {
    use std::signer;
    use std::debug::print;

    struct Calculator has key {
        result: u64,
    }

    public entry fun create_calculator(account: &signer){
        let calculator = Calculator { result: 0 };
        move_to(account, calculator);
    }

    public entry fun add(account: &signer, num1: u64, num2: u64) acquires Calculator {
        let calculator = borrow_global_mut<Calculator>(signer:: address_of(account));
        calculator.result = num1 + num2;
    }

    public entry fun substract(account: &signer, num1: u64, num2: u64) acquires Calculator {
        let calculator = borrow_global_mut<Calculator>(signer:: address_of(account));
        if (num1 > num2) {
            calculator.result = num1 - num2;
        } else {
            calculator.result = num2 - num1;
        }
    }

    public entry fun multiply(account: &signer, num1: u64, num2: u64) acquires Calculator {
        let calculator = borrow_global_mut<Calculator>(signer:: address_of(account));
        calculator.result = num1 * num2;
    }

    public fun get_result (account: &signer) : u64 acquires Calculator {
        let calculator = borrow_global<Calculator>(signer:: address_of(account));
        calculator.result
    }

    #[test(account = @0x1)]
    public fun testing(account: &signer) acquires Calculator { 
        create_calculator(account);
        // add(account, 5, 10);
        substract(account, 5, 10);
        print(&get_result(account));
    }
}