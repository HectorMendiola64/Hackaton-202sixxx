//
//  HelpCenterStore.swift
//  Hackaton
//
//  Created by Assistant on 24/03/26.
//

import Foundation
import CoreLocation
import Combine

final class HelpCenterStore: ObservableObject {
    static let shared = HelpCenterStore()

    @Published private(set) var centers: [HelpCenter] = []

    private init() {}

    // Carga desde el bundle si aún no hay datos en memoria
    func loadIfNeeded() {
        guard centers.isEmpty else { return }
        if let url = Bundle.main.url(forResource: "HelpCenters", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([HelpCenter].self, from: data) {
            centers = decoded
        } else {
            // Fallback embebido para funcionamiento offline
            centers = [
                HelpCenter(name: "Centro Histórico", latitude: 19.432608, longitude: -99.133209),
                HelpCenter(name: "Condesa", latitude: 19.411, longitude: -99.175),
                HelpCenter(name: "Coyoacán", latitude: 19.349, longitude: -99.161)
            ]
        }
    }

    // Permite que el chat bot encuentre el centro más cercano a una ubicación dada
    func nearest(to location: CLLocationCoordinate2D) -> HelpCenter? {
        guard !centers.isEmpty else { return nil }
        let userLoc = CLLocation(latitude: location.latitude, longitude: location.longitude)
        return centers.min { a, b in
            let la = CLLocation(latitude: a.latitude, longitude: a.longitude)
            let lb = CLLocation(latitude: b.latitude, longitude: b.longitude)
            return la.distance(from: userLoc) < lb.distance(from: userLoc)
        }
    }

    // Búsqueda por nombre (case-insensitive) para uso desde el chat bot
    func search(by query: String) -> [HelpCenter] {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return centers }
        let q = query.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        return centers.filter { center in
            center.name.folding(options: .diacriticInsensitive, locale: .current).lowercased().contains(q)
        }
    }

    // Resumen legible para mostrar en el chat bot
    func summaryList(limit: Int? = nil) -> String {
        let items = limit != nil ? Array(centers.prefix(limit!)) : centers
        if items.isEmpty { return "No hay centros disponibles en este momento." }
        return items.enumerated().map { idx, c in
            "\(idx + 1). \(c.name) — lat: \(String(format: "%.4f", c.latitude)), lon: \(String(format: "%.4f", c.longitude))"
        }.joined(separator: "\n")
    }
}

