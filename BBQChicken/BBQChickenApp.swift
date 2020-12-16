//
//  BBQChickenApp.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/19/20.
//

import SwiftUI

@main
struct BBQChickenApp: App {
    var body: some Scene {
        WindowGroup {
            VersusView(viewModel: VersusViewModel())
                .environmentObject(AppFontFamilyProvider(fontFamily: .system))
        }
    }
}
