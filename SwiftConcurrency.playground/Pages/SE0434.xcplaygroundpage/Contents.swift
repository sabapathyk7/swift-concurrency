//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

///SE-0434 - Usability of global-actor-isolated types

/*  Uncomment to test in Swift 6

// Problem
@MainActor
struct SomeMainActorType {
    let x: Int
    var y: Int
    nonisolated func readValues() {
        print(x) // this is allowed!
        print(y) // this is not?
        //        Main actor-isolated property 'y' can not be referenced from a non-isolated context
    }
}

// Problem - 2
let closure = { @MainActor in   //  Let 'closure' is not concurrency-safe because it is not either conforming to 'Sendable' or isolated to a global actor; this is an error in Swift 6
    // capture a bunch of non-Sendable stuff
}
Task {
    // Error: capturing non-Sendable `closure`
    await closure()
}

*/
