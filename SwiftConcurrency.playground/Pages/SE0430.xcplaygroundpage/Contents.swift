//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
/// SE-0430 - Adds a new Sending parameter  Refer - https://www.massicotte.org/concurrency-swift-6-se-0431

/*

 Check the sending keyword in the Apple documentation - Task.init

@discardableResult
init(
    executorPreference taskExecutor: consuming (any TaskExecutor)?,
    priority: TaskPriority? = nil,
    operation: sending @escaping () async throws -> Success
)
*/
