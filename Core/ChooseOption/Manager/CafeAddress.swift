//
//  LocationManager.swift
//  Bites
//
//  Created by Диас Сайынов on 09.05.2024.
//

import SwiftUI
import CoreLocation

struct CafeAddress: Identifiable {
    let id: UUID
    let name: String // Name of the cafe
    let coordinate: CLLocationCoordinate2D
    let weekDayTime: String
    let weekEndTime: String
    
    init(name: String, coordinate: CLLocationCoordinate2D, weekDayTime: String, weekEndTime: String) {
        self.id = UUID() // Assign a unique ID
        self.name = name
        self.coordinate = coordinate
        self.weekDayTime = weekDayTime
        self.weekEndTime = weekEndTime
    }
}
