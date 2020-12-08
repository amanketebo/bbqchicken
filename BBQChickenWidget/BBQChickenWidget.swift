//
//  BBQChickenWidget.swift
//  BBQChickenWidget
//
//  Created by Amanuel Ketebo on 12/7/20.
//

import WidgetKit
import SwiftUI

struct BBQChickenWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        let viewModel = VersusPlayerViewModel(player: entry.player,
                                              widgetFamily: widgetFamily)

        VStack(spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text(entry.player.fullName)
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.1)
                Spacer()
            }
            VStack(spacing: 8) {
                ForEach(viewModel.statRows) { viewModel in
                    HStack {
                        switch widgetFamily {
                        case .systemLarge,
                             .systemMedium:
                            Text(viewModel.title)
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                            Spacer()
                            Text(viewModel.detail)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                        case .systemSmall:
                            Text("\(viewModel.title) \(viewModel.detail)")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()

                        @unknown default:
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
               maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
               alignment: .center)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.backgroundLightBlue,
                                                       Color.backgroundBlue,
                                                       Color.backgroundPurple]),
                           startPoint: .top,
                           endPoint: .bottom)
        )
    }
}

@main
struct BBQChickenWidget: Widget {
    let kind: String = "BBQChickenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BBQChickenWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("BBQChicken")
        .description("Shows recent player stats from BBQChicken app.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct BBQChickenWidget_Previews: PreviewProvider {
    static var previews: some View {
        let entry = SimpleEntry(date: Date(), player: MockPlayers.kobeBryant)

        BBQChickenWidgetEntryView(entry: entry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))

        BBQChickenWidgetEntryView(entry: entry)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
