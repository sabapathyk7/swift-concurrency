//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
/*
//: [Next](@next)

//SE-0420: Inheritance of actor isolation

func doStuff(isolatedTo actor: isolated (any Actor)?) async {
}

// this is non-isolated
await doStuff(isolatedTo: nil)


func doStuff(isolatedTo actor: isolated (any Actor)? = #isolation) async {
}

@MainActor
class MyClass {
    func doLotsOfStuff() {
        await doStuff()
        await doStuff()
        await doStuff()
    }
}


//SE-0423: Dynamic actor isolation enforcement from non-strict-concurrency contexts
@MainActor
class MyViewController: @preconcurrency ViewDelegateProtocol {
    func respondToUIEvent() {
        // no need for nonisolated!
    }
}


//SE-0431: `@isolated(any)` Function Types

/// Problem
func scheduleSomeWork(_ f: @Sendable @escaping () async -> Void) {
    // We've lost all the static isolation information
    // available where f was defined.
    Task {
        await f()
    }
}

func defineClosure() {
    scheduleSomeWork { @MainActor in
        print("I'm on the main actor")
    }
}

/// Solution
func scheduleSomeWork(_ f: @Sendable @escaping @isolated(any) () async -> Void) {
    // closures have properties now!
    let isolation = f.isolation

    // do something with "isolation" I guess?
}
*/
