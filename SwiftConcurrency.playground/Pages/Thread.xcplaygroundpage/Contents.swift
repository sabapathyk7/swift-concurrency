//: [Previous](@previous)

import Foundation
///Delayed Start
let scheduledThread = Thread {
    print("Scheduled Task Executed")
}
// Optionally, delay the start of the thread
DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    scheduledThread.start()  // Starts after a 2-second delay
}

/// Timer sources
let timerThread = Thread {
    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
        print("Timer fired!")
    }
    RunLoop.current.add(timer, forMode: .default)
    RunLoop.current.run()
}

timerThread.start() // uncomment to check the timer updates

/// Stopping a Thread
class Task {
    private var shouldStop = false

    func start() {
        let thread = Thread {
            while !self.shouldStop {
                print("Task running...")
                Thread.sleep(forTimeInterval: 1)
            }
        }
        thread.start()
    }

    func stop() {
        shouldStop = true
    }
}

let task = Task()
task.start()
stopTheThread()

func stopTheThread() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        task.stop() // uncomment to stop the thread
    }
}
