//: [Previous](@previous)

import Foundation

/// SE-0417 - Task Executor Preference  Refer - https://www.massicotte.org/concurrency-swift-6-se-0431
/*

nonisolated func doSomething() async {
    // ...
}

Task(executorPreference: preferredExecutor) {
    // doSomething body would execute on 'preferredExecutor'
    await doSomething()
}
// doSomething body would execute on 'default global concurrent executor'
await doSomething()

*/
