//
//  WidgetImage.swift
//  WidgetImage
//
//  Created by jekun on 2022/3/7.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct WidgetImageEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    var path: String = "http://hdjc8.com/images/logo.png"
    var body: some View {
        switch family {
        case .systemSmall:
//            WidgetImageView(url: "https://img2.baidu.com/it/u=4081159490,1049549245&fm=253&fmt=auto&app=138&f=PNG")
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 30, height: 30, alignment: .center)
            WidgetVideoView()
                .widgetURL(URL(string: "small"))
        case .systemMedium:
            WidgetImageView(url: path)
                .aspectRatio(contentMode: .fit)
                .widgetURL(URL(string: "medium"))
        case .systemLarge:
            WidgetImageView(url: "https://img1.baidu.com/it/u=1110022854,3922459600&fm=253&fmt=auto&app=138&f=PNG")
                .aspectRatio(contentMode: .fill)
                .widgetURL(URL(string: "large"))
        default:
            Text(entry.date, style: .timer).frame(width: 44, height: 20, alignment: .center)
        }
    }
    
    /*
     Widget点击交互
     点击Widget窗口唤起APP进行交互指定跳转支持两种方式：

     1、widgetURL：点击区域是Widget的所有区域，适合元素、逻辑简单的小部件

     2、Link：通过Link修饰，允许让界面上不同元素产生点击响应

     3、systemSmall只能用widgetURL实现URL传递接收

     4、systemMedium、systemLarge可以用Link或者widgetUrl处理
     
     */
}

@main
struct WidgetImage: Widget {
    let kind: String = "WidgetImage"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetImageEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
