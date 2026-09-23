//
//  ContentView.swift
//  AppleShowcase
//
//  Created by Iulian Albu on 12/09/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: ShowcaseCategory? = .buttons
    @State private var searchText = ""

    private var filteredCategories: [ShowcaseCategory] {
        guard !searchText.isEmpty else { return ShowcaseCategory.allCases }
        return ShowcaseCategory.allCases.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationSplitView {
            List(filteredCategories, selection: $selection) { category in
                Label(category.title, systemImage: category.symbol)
                    .badge(category == .foundationModels ? 3 : 0)
            }
            .navigationTitle("HIG Showcase")
            .navigationSplitViewColumnWidth(min: 180, ideal: 210)
            .searchable(text: $searchText, placement: .sidebar, prompt: "Search Categories")
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
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button("Refresh", systemImage: "arrow.clockwise") {}
                    Menu {
                        Button("Copy Link", systemImage: "link") {}
                        Button("Open in HIG", systemImage: "book") {}
                    } label: {
                        Label("More", systemImage: "ellipsis.circle")
                    }
                }
            }
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
