//: [Previous](@previous)

import Foundation

/// SE-0418 - Inferring Sendable for methods and key path literals  Refer - https://www.massicotte.org/concurrency-swift-6-se-0431

struct MyStruct: Sendable {
    var value: Int
    func update() -> Int {
        return value
    }
}
@MainActor let keyPath: KeyPath<MyStruct, Int> = \.value

