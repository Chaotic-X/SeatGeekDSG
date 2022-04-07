//
//  URLSession-Codable.swift
//  SeatGeekDSG
//
//  Created by Alex Lundquist on 4/5/22.
//

import Combine
import Foundation

extension URLSession {
    func fetch<T: Decodable>(_ url: URL, defaultValue: T, completion: @escaping (T) -> Void) -> AnyCancellable {
        let decoder = JSONDecoder()

        return self.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .replaceError(with: defaultValue)
            .receive(on: RunLoop.main)
            .sink(receiveValue: completion)
    }

    func get<T: Decodable>(path: String, queryItems: [String: String] = [:], defaultValue: T, completion: @escaping (T) -> Void) -> AnyCancellable? {
        guard var components = URLComponents(string: "https://api.seatgeek.com/\(path)") else {
            return nil
        }

        components.queryItems = [URLQueryItem(name: "client_id", value: "MjY0MjA0OTB8MTY0OTExMTAyMS41NTE3NDg4")] + queryItems.map(URLQueryItem.init)

        if let url = components.url {
            print(url.absoluteString)
            return fetch(url, defaultValue: defaultValue, completion: completion)
        } else {
            return nil
        }
    }
    
}
