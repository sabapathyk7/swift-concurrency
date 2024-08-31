//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

/// SE-0431 - @isolated(any) Function Types - Refer - https://www.massicotte.org/concurrency-swift-6-se-0431

/*  Uncomment to test in Swift 6

/// Problem
func scheduleSomeWork(_ f: @Sendable @escaping () async -> Void) {
    // We've lost all the static isolation information
    // available where f was defined.
    Task {
        await f()
    }
}
/// Problem 2
func defineClosure() {
    scheduleSomeWork { @MainActor in
        print("I'm on the main actor")
    }
}
*/

/*

/// Solution
func scheduleSomeWork(_ f: @Sendable @escaping @isolated(any) () async -> Void) {
    // closures have properties now!
    let isolation = f.isolation
    // do something with "isolation" I guess?
}


*/
