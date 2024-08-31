//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

/// SE-0423 - Dynamic Isolation enforcement from non-strict-concurrency contexts  Refer - https://www.massicotte.org/concurrency-swift-6-se-0431

/*
 Uncomment to test in Swift 6

@MainActor
class MyViewController: @preconcurrency ViewDelegateProtocol {
    func respondToUIEvent() {
        // no need for nonisolated!
    }
}

*/
