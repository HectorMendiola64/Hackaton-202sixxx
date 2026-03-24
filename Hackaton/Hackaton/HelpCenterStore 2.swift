//
//  HelpCenterStore.swift
//  Hackaton
//
//  Created by Assistant on 24/03/26.
//

import Foundation
import Combine

// Observable store for help centers used by MapaView
final class HelpCenterStoreStub: ObservableObject {
    static let shared = HelpCenterStoreStub()

    // Published list of centers
    @Published private(set) var centers: [HelpCenter] = []

    private init() {}

    // Loads centers once; replace stub with real networking or persistence later
    func loadIfNeeded() {
        guard centers.isEmpty else { return }

        let samples: [HelpCenter] = [
            HelpCenter(name: "Centro Histórico", latitude: 19.432608, longitude: -99.133209),
            HelpCenter(name: "Condesa", latitude: 19.4119, longitude: -99.1749),
            HelpCenter(name: "Polanco", latitude: 19.4330, longitude: -99.1979),
            HelpCenter(name: "Coyoacán", latitude: 19.3467, longitude: -99.1617)
        ]

        if Thread.isMainThread {
            self.centers = samples
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.centers = samples
            }
        }
    }
}

