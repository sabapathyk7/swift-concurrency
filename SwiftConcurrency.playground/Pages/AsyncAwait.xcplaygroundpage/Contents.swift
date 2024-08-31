//: [Previous](@previous)

import Foundation


// Define a function that simulates an asynchronous task
func performTask(taskNumber: Int) async {
    print("Task \(taskNumber) started.")
    do {
        try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate some asynchronous work (1 second)
        print("Task \(taskNumber) completed.")
    } catch {
        print(error)
    }
}

