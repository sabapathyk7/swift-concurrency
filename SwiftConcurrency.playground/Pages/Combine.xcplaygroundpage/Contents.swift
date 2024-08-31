//: [Previous](@previous)
import Combine
import Foundation

var greeting = "Hello, playground"

// A simple publisher that emits integers from 1 to 5
let numberPublisher = [1, 2, 3, 4, 5].publisher

// Creating a Set of AnyCancellable to store cancellable instances
var cancellables = Set<AnyCancellable>()

// Subscribing to the publisher using sink
numberPublisher
    .sink { completion in
        print("Completed: \(completion)")
    } receiveValue: { value in
        print("Received value: \(value)")
    }
    .store(in: &cancellables) // Storing the AnyCancellable in the Set

// Another publisher that emits strings
let stringPublisher = ["A", "B", "C", "D", "E"].publisher

// Subscribing to the stringPublisher using sink
stringPublisher
    .sink { completion in
        print("Completed: \(completion)")
    } receiveValue: { value in
        print("Received value: \(value)")
    }
    .store(in: &cancellables) // Storing the AnyCancellable in the Set

// At some point, when you want to cancel all the subscriptions
cancellables.forEach { $0.cancel() }


let publisher = Just("Hello Combine")
let cancellable = publisher.sink(receiveValue: { value in
    print(value)
})
cancellable.cancel()


final class TodoViewModel: ObservableObject {
    var cancellables: Set<AnyCancellable> = []

    func fetchData() {
        let publisher = URLSession.shared.dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!)
            .map(\.data)
            .decode(type: Todo.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break // Do nothing on success
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { todo in
                // Handle the received data (e.g., update UI)
                print("Received todo: \(todo.title)")
            })

        // Store the cancellable in the set
        publisher.store(in: &cancellables)
    }
}

struct Todo: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
var viewModel = TodoViewModel()
viewModel.fetchData()


