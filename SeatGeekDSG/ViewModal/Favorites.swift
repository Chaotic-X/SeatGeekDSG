//
//  Favorites.swift
//  SeatGeekDSG
//
//  Created by Alex Lundquist on 4/6/22.
//

import SwiftUI

class Favorites: ObservableObject {
    
    private var events: Set<Int>
    
    private let saveKey = "Favorites"
    
    init() {
        self.events = []
    }
    
    func contains(_ event: Event) -> Bool {
        events.contains(event.id)
    }
    
    func add(_ event: Event) {
        objectWillChange.send()
        events.insert(event.id)
    }
    
    func remove(_ event: Event) {
        objectWillChange.send()
        events.remove(event.id)
    }
    
    func removeAll() {
        objectWillChange.send()
        events.removeAll()
    }

}
