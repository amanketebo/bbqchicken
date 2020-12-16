//
//  FontStyle.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 12/16/20.
//

import SwiftUI

enum AppFontFamily {
    case system
    case christmas
}

enum AppFont {
    case headline
    case title
}

struct FontStyle: ViewModifier {
    // MARK: - Properties

    static var weightToFontNameMapping: [Font.Weight: String] = [.black: "MountainsofChristmas-Bold",
                                                                 .bold: "MountainsofChristmas-Bold",
                                                                 .semibold: "MountainsofChristmas-Bold",
                                                                 .heavy: "MountainsofChristmas-Bold",
                                                                 .light: "MountainsofChristmas-Regular",
                                                                 .medium: "MountainsofChristmas-Regular",
                                                                 .regular: "MountainsofChristmas-Regular",
                                                                 .thin: "MountainsofChristmas-Regular",
                                                                 .ultraLight: "MountainsofChristmas-Regular"]

    var appFont: AppFont
    var weight: Font.Weight
    @EnvironmentObject var appFontFamilyProvider: AppFontFamilyProvider

    // MARK: - Init

    init(appFont: AppFont, weight: Font.Weight) {
        self.appFont = appFont
        self.weight = weight
    }

    // MARK: - ViewModifier

    func body(content: Content) -> some View {
        return content.font(FontStyle.font(appFont: appFont,
                                           appFontFamily: appFontFamilyProvider.fontFamily,
                                           weight: weight))
    }

    // MARK: - Helpers

    private static func font(appFont: AppFont,
                             appFontFamily: AppFontFamily,
                             weight: Font.Weight) -> Font {
        switch (appFont, appFontFamily) {
        case (.headline, .system):
            return Font.headline.weight(weight)

        case (.headline, .christmas):
            let fontName = weightToFontNameMapping[weight] ?? "MountainsofChristmas-Bold"
            return Font.custom(fontName, size: 16, relativeTo: .headline)

        case (.title, .system):
            return Font.title.weight(weight)

        case (.title, .christmas):
            let fontName = weightToFontNameMapping[weight] ?? "MountainsofChristmas-Regular"
            return Font.custom(fontName, size: 34, relativeTo: .title)
        }
    }
}
