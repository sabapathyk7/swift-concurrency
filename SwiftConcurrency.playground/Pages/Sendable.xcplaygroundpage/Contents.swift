//: [Previous](@previous)

import Foundation

/// Date - Sendable

/// Value Types
struct User: Codable, Sendable {
    let name: String
    let age: Int
}

/// Reference types with no mutable storage
final class Address: Sendable {
    let houseNo: Int
    let streetName: String
    let cityName: String
    init(houseNo: Int, streetName: String, cityName: String) {
        self.houseNo = houseNo
        self.streetName = streetName
        self.cityName = cityName
    }
}

/// Reference types that internally manage access to their state
actor Account {
    private var balance: Int = 0

    func deposit(amount: Int) {
        balance += amount
    }

    func getBalance() -> Int {
        return balance
    }
}

/// Functions and Closures- @Sendable
func fetchData(endPoint: String, resultHandler: @Sendable @escaping (Result<User, Error>) -> Void) {
    resultHandler(.success(User(name: "Saba", age: 1)))
}

