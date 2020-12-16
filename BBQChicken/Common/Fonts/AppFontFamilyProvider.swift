//
//  AppFontFamilyProvider.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 12/16/20.
//

import Foundation

class AppFontFamilyProvider: ObservableObject {
    @Published var fontFamily: AppFontFamily

    init(fontFamily: AppFontFamily) {
        self.fontFamily = fontFamily
    }
}
