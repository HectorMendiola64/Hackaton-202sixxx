//
//  MapaView.swift
//  Hackaton
//
//  Created by Hector Mendiola on 24/03/26.
//

import SwiftUI
import MapKit
import Combine

struct HelpCenter: Identifiable, Codable {
    let name: String
    let latitude: Double
    let longitude: Double
    var id: String { "\(name)-\(latitude),\(longitude)" }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapaView: View {
    @StateObject private var store = HelpCenterStore.shared
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.432608, longitude: -99.133209),
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    )
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: store.centers) { center in
            MapAnnotation(coordinate: center.coordinate) {
                VStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                    Text(center.name)
                        .font(.caption)
                        .fixedSize()
                        .padding(4)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 6))
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            store.loadIfNeeded()
            fitRegionToCenters(using: store.centers)
        }
    }
}

#Preview {
    MapaView()
}

private extension MapaView {
    func fitRegionToCenters(using centers: [HelpCenter]) {
        guard !centers.isEmpty else { return }
        let lats = centers.map { $0.latitude }
        let lons = centers.map { $0.longitude }
        guard let minLat = lats.min(), let maxLat = lats.max(), let minLon = lons.min(), let maxLon = lons.max() else { return }

        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2.0,
                                            longitude: (minLon + maxLon) / 2.0)
        // Add padding to the span so pins are comfortably visible
        let latDelta = max(0.02, (maxLat - minLat) * 1.5)
        let lonDelta = max(0.02, (maxLon - minLon) * 1.5)
        region = MKCoordinateRegion(center: center,
                                    span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta))
    }
}

extension CLLocationCoordinate2D: Identifiable {
    public var id: String { "\(latitude),\(longitude)" }
}
