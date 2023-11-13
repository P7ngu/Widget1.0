//
//  ContentView.swift
//  widget app
//
//  Created by Matteo Perotta on 08/11/23.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    //we need it in the app group
    @AppStorage("streak", store: UserDefaults(suiteName: "group.matteo.perotta.widget-app")) var streak = 0
    
    var body: some View {
        
        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack{
                Spacer()
            //(spacing: 60){
                
                ZStack{ // for the circles
                    Circle().stroke(Color.white.opacity(0.1),
                                    lineWidth: 20)
                    
                    let percentage = Double (streak)/31.0
                    
                    Circle()
                        .trim(from: 0, to: percentage)
                        .stroke(Color.blue.opacity(0.9),
                                style: StrokeStyle(lineWidth:20, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                    
                    VStack{
                        Text("Streak: ")
                            .font(.system(size: 70))
                            .bold()
                        
                        Text (String (streak))
                            .font(.system(size: 70))
                            .bold()
                    }.foregroundStyle(.white)
                        .fontDesign(.rounded)
                    
                }
                .padding(.horizontal, 50)
                
                Spacer()
                
                Button(action: {
                    streak += 1
                    
                    //manually reload widget
                    WidgetCenter.shared.reloadTimelines(ofKind: "widgetextension")
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20.0)
                            .foregroundStyle(.blue)
                            .frame(height: 50)
                        Text("Add one")
                            .foregroundStyle(.white)
                    }
                })
                .padding(.horizontal)
                
               // Spacer()
            }
        }
    }
        
}

#Preview {
    ContentView()
}
