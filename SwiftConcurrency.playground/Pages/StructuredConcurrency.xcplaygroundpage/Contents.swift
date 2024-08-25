//: [Previous](@previous)

import UIKit

private let baseURL =  "https://picsum.photos/"
private(set) var images: [UIImage] = [UIImage]()
private func fetchImage(imageUrl: String) async throws ->  UIImage {
    do {
        guard let url = URL(string: baseURL + imageUrl) else {
            throw URLError(.badURL)
        }
        print("Val: \(imageUrl)")
        let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
        if let image = UIImage(data: data) {
            print("Image: \(image)")
            return image
        } else {
            throw URLError(.badURL)
        }
    } catch {
        if let error = error as? URLError, error.code == URLError.cancelled {
            print(error)
        } else {
            throw error
        }
    }
    return UIImage()
}

func fetchMultipleImagesArray() async throws  {
    async let image100 = fetchImage(imageUrl:"100")
    async let image101 = fetchImage(imageUrl:"101")
    async let image102 = fetchImage(imageUrl:"102")
    async let image103 = fetchImage(imageUrl:"103")
    async let image104 = fetchImage(imageUrl:"104")
    let asyncLetResult = try await ([image100,image101,image102,image103,image104])
    await MainActor.run {
        images.append(contentsOf: asyncLetResult)
    }
}
Task {
    do {
        try await fetchMultipleImagesArray()
    } catch {
        print("Failed to download images: \(error)")
    }
}
