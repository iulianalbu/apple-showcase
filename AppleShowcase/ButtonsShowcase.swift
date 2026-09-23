//
//  ButtonsShowcase.swift
//  AppleShowcase
//

import SwiftUI

struct ButtonsShowcase: View {
    @State private var isBookmarked = true
    @State private var showDeleteAlert = false

    var body: some View {
        Form {
            Section {
                Button("Automatic") {}
                Button("Bordered") {}
                    .buttonStyle(.bordered)
                Button("Bordered Prominent") {}
                    .buttonStyle(.borderedProminent)
                Button("Borderless") {}
                    .buttonStyle(.borderless)
                Button("Plain") {}
                    .buttonStyle(.plain)
                #if os(macOS)
                Button("Link") {}
                    .buttonStyle(.link)
                #else
                Link("Link", destination: URL(string: "https://developer.apple.com/design/human-interface-guidelines/buttons")!)
                #endif
            } header: {
                Text("Bordered Styles")
            } footer: {
                #if os(iOS)
                Text("The link button style is macOS-only. On iOS, use a Link view instead.")
                #endif
            }

            Section("Liquid Glass") {
                Button("Glass", systemImage: "sparkles") {}
                    .buttonStyle(.glass)
                Button("Glass Prominent", systemImage: "sparkles") {}
                    .buttonStyle(.glassProminent)
            }

            Section("Roles") {
                Button("Delete…", systemImage: "trash", role: .destructive) {
                    showDeleteAlert = true
                }
                Button("Cancel", role: .cancel) {}
            }

            Section("Control Sizes") {
                HStack {
                    Button("Mini") {}.controlSize(.mini)
                    Button("Small") {}.controlSize(.small)
                    Button("Regular") {}.controlSize(.regular)
                    Button("Large") {}.controlSize(.large)
                }
                .buttonStyle(.bordered)
            }

            Section("Shapes") {
                Button("Add", systemImage: "plus") {}
                    .labelStyle(.iconOnly)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                    .controlSize(.large)
                Button("Capsule Action") {}
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
            }

            Section("Toggle Button") {
                Toggle("Bookmarked", systemImage: "bookmark.fill", isOn: $isBookmarked)
                    .toggleStyle(.button)
            }

            #if os(iOS)
            Section {
                Button("Highlight", systemImage: "cursorarrow") {}
                    .buttonStyle(.bordered)
                    .hoverEffect(.highlight)
                Button("Lift", systemImage: "cursorarrow.rays") {}
                    .buttonStyle(.bordered)
                    .hoverEffect(.lift)
            } header: {
                Text("Pointer Hover")
            } footer: {
                Text("Hover effects appear on iPad with a trackpad or mouse.")
            }
            #endif
        }
        .formStyle(.grouped)
        .alert("Delete this item?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {}
            Button("Cancel", role: .cancel) {}
        }
    }
}

#Preview {
    ButtonsShowcase()
        .frame(width: 500, height: 600)
}
