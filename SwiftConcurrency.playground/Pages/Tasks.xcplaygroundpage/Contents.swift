//: [Previous](@previous)

import Foundation

Task {
    print("Task Started")
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    print("Task Completed")
}
Thread.sleep(forTimeInterval: 2)
print("After Sleep")

func taskWithPriority() {
    // Task QoS
    Task(priority: .high) {
        print("high Task Started")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("high Task Completed")
    }
    Task(priority: .userInitiated) {
        print("userInitiated Task Started")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("userInitiated Task Completed")
    }
    Task(priority: .medium) {
        print("medium Task Started")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("medium Task Completed")
    }
    Task(priority: .low) {
        print("low Task Started")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("low Task Completed")
    }
    Task(priority: .utility) {
        print("utility Task Started")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("utility Task Completed")
    }
    Task(priority: .background) {
        print("Background Task Started")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("Background Task Completed")
    }
}
taskWithPriority()

// Independent - Useful when you start the task that isn't tied to current context.
Task.detached {
    print("Detached Task started at \(Date())")
    try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    print("Detached Task completed at \(Date())")
}

// Group Tasks
func stucturedConcurrencyWithTaskGroup() async {
    await withTaskGroup(of: String.self) { group in
        for i in 1...3 {
            group.addTask {
                try? await Task.sleep(nanoseconds: UInt64(i) * 1_000_000_000)
                return "Group Task \(i) completed"
            }
        }
        for await result in group {
            print(result)
        }
    }
}
Task {
    await stucturedConcurrencyWithTaskGroup()
}
// Task Cancellation
func taskWithCancellation() async {
    let task = Task {
        for i in 1...3 {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            try await Task.checkCancellation()
            print("Task iteration \(i) completed")
        }
        return "Task completed"
    }

    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
        task.cancel()
    }

    do {
        let result = try await task.value
        print(result)
    } catch {
        print("Task was canceled")
    }
}

Task {
    await taskWithCancellation()
}
Thread.sleep(forTimeInterval: 7)
