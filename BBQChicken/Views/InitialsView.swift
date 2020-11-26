//
//  InitialView.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import SwiftUI

struct InitialsView: View {
    var text: String

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.gray)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
            Text(text)
                .font(.title)
                .fontWeight(.regular)
                .foregroundColor(.black)
        }
    }
}

struct InitialsView_Previews: PreviewProvider {
    static var previews: some View {
        InitialsView(text: "KB")
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
