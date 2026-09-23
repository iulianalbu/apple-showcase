//
//  DataEntryShowcase.swift
//  AppleShowcase
//

import SwiftUI

struct DataEntryShowcase: View {
    @State private var name = ""
    @State private var password = ""
    @State private var notes = "Write something…"
    @State private var date = Date()
    @State private var accentColor = Color.accentColor

    var body: some View {
        Form {
            Section("Text Input") {
                TextField("Name", text: $name, prompt: Text("Required"))
                SecureField("Password", text: $password)
            }

            Section("Multiline") {
                TextEditor(text: $notes)
                    .frame(height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.separator)
                    )
            }

            Section {
                #if os(macOS)
                DatePicker("Field with Stepper", selection: $date)
                    .datePickerStyle(.stepperField)
                #else
                DatePicker("Compact", selection: $date)
                    .datePickerStyle(.compact)
                #endif
                DatePicker("Graphical", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            } header: {
                Text("Date & Time")
            } footer: {
                #if os(iOS)
                Text("The stepper field style is macOS-only. On iOS, use a compact date picker.")
                #endif
            }

            Section("Color") {
                ColorPicker("Accent Color", selection: $accentColor)
            }
        }
        .formStyle(.grouped)
    }
}

#Preview {
    DataEntryShowcase()
        .frame(width: 500, height: 700)
}
