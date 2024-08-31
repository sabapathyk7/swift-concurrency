//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
/// SE-0420: Inheritance of actor isolation  Refer - https://www.massicotte.org/concurrency-swift-6-se-0431

/*
 Uncomment to test in Swift 6

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
 */
