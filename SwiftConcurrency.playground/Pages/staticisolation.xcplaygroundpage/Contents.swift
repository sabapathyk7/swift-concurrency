//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

// Refer Eliminate data races using Swift Concurrency https://developer.apple.com/videos/play/wwdc2022/110351/
/*
//: [Next](@next)
enum Ripeness: Sendable {
  case hard
  case perfect
  case mushy(daysPast: Int)
}

struct Pineapple: Sendable {
  var weight: Double
  var ripeness: Ripeness

  mutating func ripen() async { }
  mutating func slice() -> Int { }
}
final class Chicken {
    let name: String
    var currentHunger: HungerLevel

    func feed() { }
    func play() {}
    func produce() -> Egg {}
    init(name: String, currentHunger: HungerLevel) {
        self.name = name
        self.currentHunger = currentHunger
    }
}
actor Island {
  var flock: [Chicken]
  var food: [Pineapple]
  func advanceTime() {
    let totalSlices = food.indices.reduce(0) { (total, nextIndex) in
      total + food[nextIndex].slice()
    }
    Task {
      flock.map(Chicken.produce)
    }
    Task.detached {
      let ripePineapples = await food.filter { $0.ripeness == .perfect }
      print("There are \(ripePineapples.count) ripe pineapples on the island")
    }
  }
}
*/

//Task.detached is independent one and can't be tied in context so it's not isolated

/*

 // MainActor Isolation

@MainActor func updateView() { … }
Task { @MainActor in
    // …
  view.selectedChicken = lily
}

*/

// nonisolated
extension BankAccount: CustomStringConvertible {
    nonisolated var description: String {
        "bank \(accountHolder)"
    }
}

actor BankAccount {
    let accountHolder: String
    var balance: Int
    init(accountHolder: String, balance: Int = 0) {
        self.accountHolder = accountHolder
        self.balance = balance
    }
    func deposit(amount: Int) {
        balance += amount
    }
    func transfer(amount: Int, to: isolated BankAccount) {
        to.deposit(amount: amount)
    }
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

// preconditionIsolated
actor MyActor {
    var value: Int = 0
    func updateValue() {
        preconditionIsolated(self) // Ensures that `self` is isolated
        value += 1
    }
}
