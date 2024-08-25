import Foundation

class Counter {
    private var value: Int = 0
    private let queue = DispatchQueue(label: "com.counter.serialQueue")
    func increment() {
        queue.sync {
            value += 1
        }
    }
    func decrement() {
        queue.sync {
            value -= 1
        }
    }

    func getValue() -> Int {
        queue.sync {
            return value
        }
    }
}

let counter = Counter()
DispatchQueue.concurrentPerform(iterations: 100) { _ in
    if Bool.random() {
        print("Class ✅ \(counter.getValue())")
        counter.increment()
    } else {
        print("Class ❌ \(counter.getValue())")
        counter.decrement()
    }
}
let finalValue = counter.getValue()
print("Final value (Class): \(finalValue)")

actor ActorCounter {
    private var value: Int = 0
    func increment() {
            value += 1
    }
    func decrement() {
            value -= 1
    }

    func getValue() -> Int {
            return value
    }
}

let actorCounter = ActorCounter()
for _ in 1...1000 {
    Task {
        if Bool.random() {
            print("Actor ✅ \(await actorCounter.getValue())")
            await actorCounter.increment()
        } else {
            print("Actor ❌ \(await actorCounter.getValue())")
            await actorCounter.decrement()
        }
    }
}

Task {
    let finalValue = await actorCounter.getValue()
    print("Final value (Actor): \(finalValue)")
}



class BankAccount {
    var balance: Int = 0

    func deposit(amount: Int) {
        balance += amount
    }
}

let account = BankAccount()

// Simulate 10 users depositing money concurrently
DispatchQueue.concurrentPerform(iterations: 10) { _ in
    account.deposit(amount: 100)
}

print("Final Balance: \(account.balance)")

actor BankAccount1 {
    private var balance: Int = 0

    func deposit(amount: Int) {
        balance += amount
    }

    func getBalance() -> Int {
        return balance
    }
}

let account1 = BankAccount1()

Task {
    // Simulate 10 users depositing money one after another safely
    for _ in 1...10 {
        await account1.deposit(amount: 100)
    }

    let finalBalance = await account1.getBalance()
    print("Final Balance: \(finalBalance)")
}


