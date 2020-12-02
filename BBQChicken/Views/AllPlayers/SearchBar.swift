//
//  SearchBar.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/25/20.
//

import Foundation
import UIKit
import SwiftUI

struct SearchBar: UIViewRepresentable {
    // MARK: - Properties

    let placeholder: String
    let onTextUpdate: ((String) -> Void)?

    // MARK: - UIViewRepresentable

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()

        searchBar.placeholder = placeholder
        searchBar.delegate = context.coordinator

        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) { }

    func makeCoordinator() -> Coordinator {
        return Coordinator(searchBar: self)
    }

    // MARK: - Coordinator

    class Coordinator: NSObject, UISearchBarDelegate {
        let searchBar: SearchBar

        init(searchBar: SearchBar) {
            self.searchBar = searchBar
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.searchBar.onTextUpdate?(searchText)
        }
    }
}

