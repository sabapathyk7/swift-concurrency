//: [Previous](@previous)

import Foundation

DispatchQueue.main.async {
    print("Main Thread")
}

let serialQueue = DispatchQueue(label: "SerialQueue")
serialQueue.sync {
    print("serialQueue Task1 Started")
    print("serialQueue Task1 finished")
}
serialQueue.async {
    print("serialQueue Task2 Started")
    print("serialQueue Task2 finished")
}
let concurrentQueue = DispatchQueue(label: "ConcurrentQueue",
                                    attributes: .concurrent)
concurrentQueue.async {
    print("Concurrent with Async - Task2 Started")
    print("Concurrent with Async - Task2 Finishes")
}
concurrentQueue.sync {
    print("Concurrent with Sync - Task1 Started")
    print("Concurrent with Sync - Task1 Finishes")
}

extension Date {
    var currentTimeStamp: Int64 {
        Int64(self.timeIntervalSince1970 * 1000)
    }
}
func concurrency() {
    print("background start Time: \(Date().currentTimeStamp) ")
    DispatchQueue.global(qos: .background).async {
        for i in 1...3{
            sleep(3)
            print("background Counter:\(i), time \(Date().currentTimeStamp) ")
        }
    }
    print("UserInitiated start Time: \(Date().currentTimeStamp) ")
    DispatchQueue.global(qos: .userInitiated).async {
        for i in 1...3{
            sleep(3)
            print("UserInitiated Counter:\(i), time \(Date().currentTimeStamp) ")
        }
    }
    print("Utility start Time: \(Date().currentTimeStamp) ")
    DispatchQueue.global(qos: .utility).async {
        for i in 1...3{
            sleep(3)
            print("Utility Counter:\(i), time \(Date().currentTimeStamp) ")
        }
    }

    print("UserInteractive start Time: \(Date().currentTimeStamp) ")
    DispatchQueue.global(qos: .userInteractive).async {
        for i in 1...3{
            sleep(3)
            print("UserInteractive Counter:\(i), time \(Date().currentTimeStamp) ")
        }
    }
    print("Default start Time: \(Date().currentTimeStamp) ")
    DispatchQueue.global(qos: .default).async {
        for i in 1...3{
            sleep(3)
            print("Default Counter:\(i), time \(Date().currentTimeStamp) ")
        }
    }
}
concurrency()

// Dispatch Barrier Example
let queue = DispatchQueue(label: "com.example.queue",
                          attributes: .concurrent)
queue.async {
    print("Task 1 started")
    sleep(2)
    print("Task 1 finished")
}
// Dispatch Barrier
queue.async(flags: .barrier) {
    print("Barrier Task started")
    sleep(3)
    print("Barrier Task finished")
}
queue.async {
    print("Task 2 started")
    sleep(1)
    print("Task 2 finished")
}

// Dispatch Semaphore
let globalQueue = DispatchQueue.global()
let semaphore = DispatchSemaphore(value: 2)  // Limit to 2 threads

for i in 1...5 {
    globalQueue.async {
        semaphore.wait()  // Wait for available resource
        print("SemaphoreTask \(i) started")
        sleep(2)
        print("SemaphoreTask \(i) finished")
        semaphore.signal()  // Release resource
    }
}

// Dispatch Group
let group = DispatchGroup()
group.enter()
queue.async {
    print("Group Task 1 started")
    sleep(2)
    print("Group Task 1 finished")
    group.leave()
}
group.enter()
queue.async {
    print("Group Task 2 started")
    sleep(1)
    print("Group Task 2 finished")
    group.leave()
}
group.notify(queue: DispatchQueue.main) {
    print("All Group tasks completed")
}

// Dispatch Sources
//let timer = DispatchSource.makeTimerSource()
//timer.setEventHandler {
//    print("Timer fired")
//}
//timer.schedule(deadline: .now(), repeating: 2.0)
//timer.activate()

// DispatchWorkItem
let workItem = DispatchWorkItem {
    print("Work Item executed")
}
globalQueue.async(execute: workItem)
workItem.cancel()
