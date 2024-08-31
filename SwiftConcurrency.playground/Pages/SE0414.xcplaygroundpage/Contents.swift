//: [Previous](@previous)

import Foundation

/// SE-0414 - Region-based Isolation  Refer - https://www.massicotte.org/concurrency-swift-6-se-0431

/*
 Warning in Swift 5.10
 */
class NonSendable {}
func doSomething(with: NonSendable) async {}
@MainActor
func modifyOnMainActor(_ x: NonSendable) async {
    let value = NonSendable()
    // WARNING: Passing argument of non-sendable type 'NonSendable' outside
    // of main actor-isolated context may introduce data races
    await doSomething(with: x)
}

/*
 Swift 6
 */
struct Animal: Sendable {}
class NonSendableSafe {
    var animal: Animal
    init(animal: Animal) {
        self.animal = animal
    }
}
func doSomething(with x: NonSendableSafe) async {
    x.animal = Animal()
}
@MainActor
func modifyOnMainActor(_ x: NonSendableSafe) async {
    let value = NonSendableSafe(animal: Animal())
    await doSomething(with: x)
    _ = x.animal // Doesn't produce ERROR - could race with doSomeThing
}
