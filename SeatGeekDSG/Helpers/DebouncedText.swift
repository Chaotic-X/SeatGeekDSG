//
//  DebouncedText.swift
//  SeatGeekDSG
//
//  Created by Alex Lundquist on 4/5/22.
//

import Combine
import Foundation

class DebouncedText: ObservableObject {
    @Published var text = ""
    @Published var debouncedText = ""

    private var textDebounce: AnyCancellable?

    init() {
        textDebounce = $text
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.debouncedText = $0
            }
    }
}
