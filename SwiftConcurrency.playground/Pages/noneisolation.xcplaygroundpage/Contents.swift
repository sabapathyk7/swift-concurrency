//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
/*
// Example of None Isolation
extension Island {
  nonisolated func meetTheFlock() async {
    let flockNames = await flock.map { $0.name }
    print("Meet our fabulous flock: \(flockNames)")
  }
}
*/

// None-isolation and synchronous function
func syncFunction() -> Int {
    return 7
}
