//
//  SelectionControlsShowcase.swift
//  AppleShowcase
//

import SwiftUI

struct SelectionControlsShowcase: View {
    @State private var isEnabled = true
    @State private var isChecked = true
    @State private var menuFlavor = "Vanilla"
    @State private var radioFlavor = "Chocolate"
    @State private var alignment = 1
    @State private var quantity = 3
    @State private var volume = 0.5

    private let flavors = ["Vanilla", "Chocolate", "Strawberry", "Mint"]

    var body: some View {
        Form {
            Section("Toggles") {
                Toggle("Switch Style", isOn: $isEnabled)
                    .toggleStyle(.switch)
                Toggle("Checkbox Style", isOn: $isChecked)
                    .toggleStyle(.checkbox)
            }

            Section("Pickers") {
                Picker("Menu", selection: $menuFlavor) {
                    ForEach(flavors, id: \.self) { Text($0) }
                }
                Picker("Segmented", selection: $alignment) {
                    Text("Left").tag(0)
                    Text("Center").tag(1)
                    Text("Right").tag(2)
                }
                .pickerStyle(.segmented)
                Picker("Radio Group", selection: $radioFlavor) {
                    ForEach(flavors, id: \.self) { Text($0) }
                }
                .pickerStyle(.radioGroup)
            }

            Section("Stepper") {
                Stepper("Quantity: \(quantity)", value: $quantity, in: 0...10)
            }

            Section("Slider") {
                LabeledContent("Volume") {
                    Slider(value: $volume, in: 0...1)
                }
                Slider(value: $volume, in: 0...1) {
                    Text("Volume")
                } minimumValueLabel: {
                    Image(systemName: "speaker.fill")
                } maximumValueLabel: {
                    Image(systemName: "speaker.wave.3.fill")
                }
            }
        }
        .formStyle(.grouped)
    }
}

#Preview {
    SelectionControlsShowcase()
        .frame(width: 500, height: 600)
}
