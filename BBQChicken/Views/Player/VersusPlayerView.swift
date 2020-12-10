//
//  VersusPlayerView.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import SwiftUI

struct VersusPlayerView: View {
    
    // MARK: - Properties
    
    var viewModel: VersusPlayerViewModel
    @State private var isCollapsed = false

    var body: some View {
        ZStack {
            if viewModel.shouldShowCollapseButton {
                HStack {
                    Button(action: {
                        isCollapsed.toggle()
                        print("whhat")
                    }, label: {
                        if isCollapsed {
                            Image(systemName: "chevron.down.circle.fill")
                        } else {
                            Image(systemName: "chevron.up.circle.fill")
                        }
                    })
                    .frame(width: 60, height: 60, alignment: .center)
                }
                .frame(minWidth: 0,
                       idealWidth: 100,
                       maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                       idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,
                       maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       alignment: .topTrailing)
                .offset(x: 20, y: -20)
            }
            VStack(alignment: .center, spacing: 20) {
                switch viewModel.layout {
                case .showStats:
                    HStack {
                        InitialsView(text: viewModel.initialsText)
                            .frame(width: 75, height: 75, alignment: .center)
                        Text(viewModel.fullNameText)
                            .font(.title)
                            .foregroundColor(.primary)
                        Spacer()
                    }

                case .pickPlayer:
                    InitialsView(text: viewModel.initialsText)
                        .frame(width: 150, height: 150, alignment: .center)
                    Text(viewModel.fullNameText)
                        .font(.title)
                        .foregroundColor(.primary)
                }

                if !isCollapsed {
                    ForEach(viewModel.statRows) { viewModel in
                        HStack {
                            Text(viewModel.title)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                            Spacer()
                            Text(viewModel.detail)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
        }
    }
}

struct VersusPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let colorScheme = ColorScheme.dark
        let viewModel = VersusPlayerViewModel(player: MockPlayers.kobeBryant)
        
        VersusPlayerView(viewModel: viewModel)
            .background(Color.background)
            .previewLayout(.fixed(width: 300, height: 200))
            .environment(\.colorScheme, colorScheme)
    }
}
