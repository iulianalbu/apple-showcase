//
//  MenusNavigationShowcase.swift
//  AppleShowcase
//

import SwiftUI

struct MenusNavigationShowcase: View {
    @State private var showSheet = false
    @State private var showConfirm = false
    @State private var showPopover = false
    @State private var favoriteColor = "Red"

    #if os(macOS)
    private let contextMenuPrompt: LocalizedStringKey = "Right-click me"
    #else
    private let contextMenuPrompt: LocalizedStringKey = "Long-press me"
    #endif

    var body: some View {
        Form {
            Section("Menus") {
                Menu("Actions") {
                    Button("Duplicate", systemImage: "plus.square.on.square") {}
                    Button("Rename", systemImage: "pencil") {}
                    Divider()
                    Button("Delete", systemImage: "trash", role: .destructive) {}
                }
                Menu {
                    Picker("Favorite Color", selection: $favoriteColor) {
                        Text("Red").tag("Red")
                        Text("Green").tag("Green")
                        Text("Blue").tag("Blue")
                    }
                } label: {
                    Label("Favorite Color: \(favoriteColor)", systemImage: "paintpalette")
                }
            }

            Section("Context Menu") {
                Text(contextMenuPrompt)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                    .contextMenu {
                        Button("Copy", systemImage: "doc.on.doc") {}
                        Button("Delete", systemImage: "trash", role: .destructive) {}
                    }
            }

            Section("Presentations") {
                Button("Show Sheet") { showSheet = true }
                Button("Show Confirmation Dialog") { showConfirm = true }
                Button("Show Popover") { showPopover = true }
                    .popover(isPresented: $showPopover) {
                        Text("This is a popover")
                            .padding()
                    }
                ShareLink(item: URL(string: "https://developer.apple.com")!)
            }
        }
        .formStyle(.grouped)
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 16) {
                Text("Sheet Presentation")
                    .font(.headline)
                Button("Dismiss") { showSheet = false }
            }
            .padding()
            #if os(macOS)
            .frame(width: 300, height: 150)
            #else
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
            #endif
        }
        .confirmationDialog("Are you sure?", isPresented: $showConfirm, titleVisibility: .visible) {
            Button("Confirm", role: .destructive) {}
            Button("Cancel", role: .cancel) {}
        }
    }
}

#Preview {
    MenusNavigationShowcase()
        .frame(width: 500, height: 600)
}
