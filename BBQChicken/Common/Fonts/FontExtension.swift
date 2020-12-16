//
//  FontExtension.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 12/15/20.
//

import SwiftUI

extension View {
    func font(appFont: AppFont, weight: Font.Weight) -> some View {
        self.modifier(FontStyle(appFont: appFont, weight: weight))
    }
}
