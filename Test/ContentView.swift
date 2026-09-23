//
//  ContentView.swift
//  Test
//
//  Created by Iulian Albu on 12/09/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: ShowcaseCategory? = .buttons

    var body: some View {
        NavigationSplitView {
            List(ShowcaseCategory.allCases, selection: $selection) { category in
                Label(category.title, systemImage: category.symbol)
            }
            .navigationTitle("HIG Showcase")
            .navigationSplitViewColumnWidth(min: 180, ideal: 210)
        } detail: {
            Group {
                switch selection {
                case .buttons:
                    ButtonsShowcase()
                case .selection:
                    SelectionControlsShowcase()
                case .dataEntry:
                    DataEntryShowcase()
                case .feedback:
                    FeedbackShowcase()
                case .dataDisplay:
                    DataDisplayShowcase()
                case .menus:
                    MenusNavigationShowcase()
                case .foundationModels:
                    FoundationModelsShowcase()
                case nil:
                    ContentUnavailableView(
                        "Select a Category",
                        systemImage: "sidebar.left",
                        description: Text("Choose a component category from the sidebar.")
                    )
                }
            }
            .navigationTitle(selection?.title ?? "HIG Showcase")
        }
    }
}

#Preview("Light") {
    ContentView()
        .frame(width: 900, height: 650)
}

#Preview("Dark") {
    ContentView()
        .frame(width: 900, height: 650)
        .preferredColorScheme(.dark)
}

#Preview("Dynamic Type XXL") {
    ContentView()
        .frame(width: 900, height: 650)
        .environment(\.dynamicTypeSize, .xxxLarge)
}
