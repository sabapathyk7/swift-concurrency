//: [Previous](@previous)

import Foundation
// Basic Operations
let operationQueue = OperationQueue()
operationQueue.maxConcurrentOperationCount = 2

let operation1 = BlockOperation {
    print("Operation 1")
}
operationQueue.addOperation(operation1)
// Dependency
let operation2 = BlockOperation {
    print("Operation 2")
}

let operation3 = BlockOperation {
    print("Operation 3 depends on Operation 2")
}
operation3.addDependency(operation2)

operationQueue.addOperations([operation2, operation3], waitUntilFinished: false)

OperationQueue.main.addOperation {
    print("Operation - Main Thread")
}

operationQueue.qualityOfService = .background
operationQueue.addOperation {
    print("Operation - Background Thread")
}


let blockOperation = BlockOperation {
    for i in 0..<10000 {
        guard !blockOperation.isCancelled else {
            print("Operation was cancelled")
            return
        }
        print(i)
    }
}

operationQueue.addOperation(blockOperation)

// Cancel the operation after some time
DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
    blockOperation.cancel()
}

extension Date {
    var currentTimeStamp: Int64 {
        Int64(self.timeIntervalSince1970 * 1000)
    }
}
func concurrencyWithOperationQueue() {
    let queue = OperationQueue()
    let backgroundOperation = BlockOperation {
        print("background start Time: \(Date().currentTimeStamp)")
        for i in 1...3 {
            sleep(3)
            print("background Counter:\(i), time \(Date().currentTimeStamp)")
        }
    }
    backgroundOperation.qualityOfService = .background
    let userInitiatedOperation = BlockOperation {
        print("UserInitiated start Time: \(Date().currentTimeStamp)")
        for i in 1...3 {
            sleep(3)
            print("UserInitiated Counter:\(i), time \(Date().currentTimeStamp)")
        }
    }
    userInitiatedOperation.qualityOfService = .userInitiated
    let utilityOperation = BlockOperation {
        print("Utility start Time: \(Date().currentTimeStamp)")
        for i in 1...3 {
            sleep(3)
            print("Utility Counter:\(i), time \(Date().currentTimeStamp)")
        }
    }
    utilityOperation.qualityOfService = .utility
    let userInteractiveOperation = BlockOperation {
        print("UserInteractive start Time: \(Date().currentTimeStamp)")
        for i in 1...3 {
            sleep(3)
            print("UserInteractive Counter:\(i), time \(Date().currentTimeStamp)")
        }
    }
    userInteractiveOperation.qualityOfService = .userInteractive
    let defaultOperation = BlockOperation {
        print("Default start Time: \(Date().currentTimeStamp)")
        for i in 1...3 {
            sleep(3)
            print("Default Counter:\(i), time \(Date().currentTimeStamp)")
        }
    }
    defaultOperation.qualityOfService = .default
    queue.addOperations([backgroundOperation, userInitiatedOperation, utilityOperation, userInteractiveOperation, defaultOperation], waitUntilFinished: false)
}
concurrencyWithOperationQueue()


class SimpleAsyncOperation: Operation {
    private var taskCompleted = false

    override var isAsynchronous: Bool { true }
    override var isFinished: Bool { taskCompleted }
    override var isExecuting: Bool { !taskCompleted }

    override func start() {
        guard !isCancelled else {
            taskCompleted = true
            return
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            print("Async task completed")
            self.taskCompleted = true
        }
    }
}
let queue = OperationQueue()
let asyncOp = SimpleAsyncOperation()
asyncOp.completionBlock = {
    print("Operation has finished.")
}
queue.addOperation(asyncOp)
