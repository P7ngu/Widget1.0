//
//  widgetextension.swift
//  widgetextension
//
//  Created by Matteo Perotta on 08/11/23.
//

import WidgetKit
import SwiftUI

//when the app is on foreground you can update the widget, or also when they tap on the widget
// app group is for multiple targets to share resources, including data, here we need it for the app storage value

struct Provider: TimelineProvider {
    
    let data = DataService()
    
    func placeholder(in context: Context) -> SimpleEntry {
        //entry only for placeholders, in the widget gallery etc.
        SimpleEntry(date: Date(), streak: data.progress())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        //provides a timeline entry with the current state, an instance in time
        let entry = SimpleEntry(date: Date(), streak: data.progress())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, streak: data.progress())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry { //data for a single snapshot
    let date: Date
    let streak: Int
}

struct widgetextensionEntryView : View { //what is seen on the screen, plus the data of the entry
    var entry: Provider.Entry
    
    let data = DataService()

    var body: some View {
        VStack {
            ZStack{ // for the circles
                Circle().stroke(Color.white.opacity(0.1),
                                lineWidth: 20)
                let percentage = Double (data.progress())/31.0
                
                Circle()
                    .trim(from: 0, to: percentage)
                    .stroke(Color.blue.opacity(0.9),
                            style: StrokeStyle(lineWidth:20, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(-90))
                
                VStack{
                    Text("Streak: ")
                        .bold()
                    
                    Text(String(data.progress()))
                        .font(.title)
                        .bold()
                }.foregroundStyle(.black)
                    .fontDesign(.rounded)
            }
            .padding()
            .containerBackground(.black, for: .widget)
        }
    }
}

struct widgetextension: Widget {
    let kind: String = "widgetextension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                widgetextensionEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                widgetextensionEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    widgetextension()
} timeline: {
    SimpleEntry(date: .now, streak: 1)
    SimpleEntry(date: .now, streak: 4)
}
