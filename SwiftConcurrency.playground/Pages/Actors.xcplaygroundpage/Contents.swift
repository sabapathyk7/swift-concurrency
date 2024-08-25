//: [Previous](@previous)

import Foundation

class Counter {
    var value = 0

    func increment() -> Int {
        let currentValue = value
        Thread.sleep(forTimeInterval: 0.1)
        value = currentValue + 1
        return value
    }
}
let counter = Counter()
Task.detached {
    print("Class 🎾 \(counter.increment())")
}

Task.detached {
    print("Class 🥎 \(counter.increment())")
}

actor SafeCounter {
    var value = 0

    func increment() -> Int {
        let currentValue = value
        Thread.sleep(forTimeInterval: 0.1)
        value = currentValue + 1
        return value
    }
}
let safeCounter = SafeCounter()
Task.detached {
    print("Actor ⚽️ \(await safeCounter.increment())")
}

Task.detached {
    print("Actor 🏀 \(await safeCounter.increment())")
}


/// Isolation Boundary
actor Account {
    private var balance: Int = 0

    func deposit(amount: Int) {
        balance += amount
    }

    func getBalance() -> Int {
        return balance
    }
}
