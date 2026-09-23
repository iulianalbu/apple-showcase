//
//  DataDisplayShowcase.swift
//  Test
//

import SwiftUI

private struct Fruit: Identifiable {
    let id = UUID()
    let name: String
    let color: String
    let calories: Int
}

private struct FileNode: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var children: [FileNode]?
}

private let sampleTree: [FileNode] = [
    FileNode(name: "Documents", icon: "folder", children: [
        FileNode(name: "Resume.pdf", icon: "doc", children: nil),
        FileNode(name: "Photos", icon: "folder", children: [
            FileNode(name: "Vacation.heic", icon: "photo", children: nil)
        ])
    ])
]

struct DataDisplayShowcase: View {
    @State private var fruits = [
        Fruit(name: "Apple", color: "Red", calories: 95),
        Fruit(name: "Banana", color: "Yellow", calories: 105),
        Fruit(name: "Grape", color: "Purple", calories: 62),
        Fruit(name: "Kiwi", color: "Green", calories: 61)
    ]
    @State private var sortOrder = [KeyPathComparator(\Fruit.name)]
    @State private var tableSelection: Fruit.ID?

    var body: some View {
        Form {
            Section("Table") {
                Table(fruits, selection: $tableSelection, sortOrder: $sortOrder) {
                    TableColumn("Name", value: \.name)
                    TableColumn("Color", value: \.color)
                    TableColumn("Calories") { fruit in
                        Text("\(fruit.calories)")
                    }
                    .width(80)
                }
                .frame(height: 160)
                .onChange(of: sortOrder) { _, newOrder in
                    fruits.sort(using: newOrder)
                }
            }

            Section("Disclosure & Grouping") {
                DisclosureGroup("Advanced Options") {
                    Toggle("Enable Logging", isOn: .constant(true))
                    Toggle("Verbose Mode", isOn: .constant(false))
                }
                GroupBox("Storage") {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("120 GB of 256 GB used")
                        ProgressView(value: 0.47)
                    }
                }
            }

            Section("Outline") {
                OutlineGroup(sampleTree, children: \.children) { node in
                    Label(node.name, systemImage: node.icon)
                }
            }
        }
        .formStyle(.grouped)
    }
}

#Preview {
    DataDisplayShowcase()
        .frame(width: 560, height: 700)
}
