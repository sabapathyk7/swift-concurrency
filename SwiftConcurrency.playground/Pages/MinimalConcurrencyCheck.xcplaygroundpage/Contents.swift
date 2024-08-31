
// Minimal Failure cases

actor BankAccountMinimalExample {
    var balance: Int = 0

    func deposit(amount: Int) {
        balance += amount
    }
}

func performTransaction(account: BankAccountMinimalExample, amount: Int) {
    Task {
        // This access is minimally checked. Direct access to balance is allowed.
//        account.balance += amount  // add await
    }
}


actor BankAccountMinimalConcurrentCheck {
    var balance: Int = 0

    func deposit(amount: Int) {
        balance += amount
    }
}

func performTransaction(account: BankAccountMinimalConcurrentCheck, amount: Int) {
    Task {
        await account.deposit(amount: amount)
    }
}



/// Failure case for Complete concurrency checking
actor BankAccount {
    private var balance: Int = 0

    func deposit(amount: Int) {
        balance += amount
    }

    func updateBalance(amount: Int) {
        balance += amount
    }
}

func performTransaction(account: BankAccount, amount: Int) {
    Task {
//        account.updateBalance(amount: amount) // Uncomment
        // Expression is 'async' but is not marked with 'await'
    }
}


/// Success case for Complete concurrency checking

actor BankAccountCompleteCheck {
    private var balance: Int = 0
    
    func deposit(amount: Int) {
        balance += amount
    }

    func updateBalance(amount: Int) {
        balance += amount
    }

    func getBalance() -> Int {
        return balance
    }
}

func performTransaction(account: BankAccountCompleteCheck, amount: Int) async {
    // Proper usage of 'await' to respect complete concurrency checks
    await account.updateBalance(amount: amount)
    let currentBalance = await account.getBalance()
    print("Current balance: \(currentBalance)")
}

Task {
    await performTransaction(account: BankAccount(), amount: 100)
}
