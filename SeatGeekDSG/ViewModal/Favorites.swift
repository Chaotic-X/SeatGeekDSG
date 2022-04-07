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
    
    let defaults = UserDefaults.standard
    
    init() {
        let loadedArray = defaults.array(forKey: saveKey) as? [Int] ?? [Int]()
        self.events = Set(loadedArray.map { $0 })
    }
    
    func contains(_ event: Event) -> Bool {
        events.contains(event.id)
    }
    
    func add(_ event: Event) {
        objectWillChange.send()
        print(event.id)
        events.insert(event.id)
        save()
    }
    
    func remove(_ event: Event) {
        objectWillChange.send()
        print(event.id)
        events.remove(event.id)
        save()
    }
    
    func save() {
        let newArray = Array(self.events)
        self.defaults.set(newArray, forKey: saveKey)
    }
    func removeAll() {
        objectWillChange.send()
        events.removeAll()
    }

}
