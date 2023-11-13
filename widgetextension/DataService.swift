//
//  DataService.swift
//  widget app
//
//  Created by Matteo Perotta on 13/11/23.
//

import Foundation
import SwiftUI

struct DataService{
    @AppStorage("streak", store: UserDefaults(suiteName: "group.matteo.perotta.widget-app")) private var streak = 0;
    
    func log() {
        streak += 1
    }
    
    func progress() -> Int {
        return streak
    }
}
