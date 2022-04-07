//
//  Event.swift
//  SeatGeekDSG
//
//  Created by Alex Lundquist on 4/4/22.
//

import Foundation

struct SearchResults: Decodable {
    var events: [Event]
}

struct Event: Decodable, Identifiable {
    let id: Int
    let type: String
    let datetime_utc: String
    let venue: Venue
    let performers: [Performers]
    
    var formattedDate: String {
        guard datetime_utc.isEmpty == false else { return "" }
        let utcISODateFormatter = ISO8601DateFormatter()
//        let dateFormatter = DateFormatter()
        if let date = utcISODateFormatter.date(from: "\(datetime_utc)Z") {
//        if let date = dateFormatter.date(from: datetime_local) {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, dd MMM yyyy hh:mm a"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    
}

struct Venue: Decodable {
    let name: String
    let state: String
    let city: String
}

struct Performers: Decodable {
    let image: String
}
