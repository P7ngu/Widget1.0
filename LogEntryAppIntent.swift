//
//  LogEntryAppIntent.swift
//  widgetextensionExtension
//
//  Created by Matteo Perotta on 13/11/23.
//

import Foundation
import AppIntents

struct LogEntryAppIntent : AppIntent{
  
    static var title: LocalizedStringResource = "Log in your streak"
    
    static var description = IntentDescription("Add 1 to current streak")
    
    func perform() async throws -> some IntentResult & ReturnsValue{
        let data = DataService()
        data.log()
        
        return .result(value: data.progress())
    }
    
    
}
