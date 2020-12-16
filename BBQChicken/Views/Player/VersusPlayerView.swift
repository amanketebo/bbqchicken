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
    private let animation = Animation.linear(duration: 0.1)

    // MARK: - View

    var body: some View {
        ZStack {
            if viewModel.shouldShowCollapseButton {
                HStack {
                    Button(action: {
                        withAnimation(animation) {
                            isCollapsed.toggle()
                        }
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
                       maxWidth: .infinity,
                       minHeight: 0,
                       idealHeight: 100,
                       maxHeight: .infinity,
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
                            .font(appFont: .title, weight: .regular)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .frame(minWidth: 100,
                           idealWidth: .infinity,
                           maxWidth: .infinity,
                           minHeight: 100,
                           idealHeight: 100,
                           maxHeight: .infinity,
                           alignment: .center)
                    .animation(animation)

                case .pickPlayer:
                    InitialsView(text: viewModel.initialsText)
                        .frame(width: 150, height: 150, alignment: .center)
                    Text(viewModel.fullNameText)
                        .font(appFont: .headline, weight: .regular)
                        .foregroundColor(.primary)
                }

                if !isCollapsed {
                    ForEach(viewModel.statRows) { viewModel in
                        HStack {
                            Text(viewModel.title)
                                .font(appFont: .headline, weight: .regular)
                                .foregroundColor(.primary)
                            Spacer()
                            Text(viewModel.detail)
                                .font(appFont: .headline, weight: .bold)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .frame(minWidth: 100,
                   idealWidth: .infinity,
                   maxWidth: .infinity,
                   minHeight: 100,
                   idealHeight: isCollapsed ? 100 : 200 ,
                   maxHeight: isCollapsed ? 100 : 200,
                   alignment: .center)
            .animation(animation)
        }
    }
}

struct VersusPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let colorScheme = ColorScheme.dark
        let viewModel = VersusPlayerViewModel(player: MockPlayers.kobeBryant)
        
        VersusPlayerView(viewModel: viewModel)
            .background(Color.background)
            .previewLayout(.fixed(width: 400, height: 400))
            .environment(\.colorScheme, colorScheme)
            .environmentObject(AppFontFamilyProvider(fontFamily: .system))
    }
}
