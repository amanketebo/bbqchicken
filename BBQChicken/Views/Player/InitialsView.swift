//
//  InitialView.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import SwiftUI

struct InitialsView: View {
    // MARK: - Properties
    
    var text: String

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.gray)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
            Text(text)
                .font(appFont: .title, weight: .regular)
                .foregroundColor(.black)
        }
    }
}

struct InitialsView_Previews: PreviewProvider {
    static var previews: some View {
        InitialsView(text: "KB")
            .previewLayout(.fixed(width: 300, height: 300))
            .environmentObject(AppFontFamilyProvider(fontFamily: .christmas))
    }
}
