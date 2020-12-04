//
//  PlayerRowView.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 12/2/20.
//

import SwiftUI

struct PlayerRowView: View {
    var playerRow: PlayerRow
    var onSelection: () -> Void

    var body: some View {
        HStack {
            Text(playerRow.text)
                .foregroundColor(.primary)
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onSelection()
        }
    }
}

struct PlayerRowView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(id: 3,
                            firstName: "James",
                            lastName: "Harden",
                            pointsPerGame: 28,
                            reboundsPerGame: 1,
                            assistsPerGame: 0)

        Group {
            ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
                let playerRow = PlayerRow(player: player)
                PlayerRowView(playerRow: playerRow) {  }
                    .background(Color.background)
                    .previewLayout(.sizeThatFits)
                    .environment(\.colorScheme, colorScheme)
                    .previewDisplayName("\(colorScheme)")
            }
        }
    }
}
