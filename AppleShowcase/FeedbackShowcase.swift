//
//  FeedbackShowcase.swift
//  AppleShowcase
//

import SwiftUI

struct FeedbackShowcase: View {
    @State private var progress = 0.4
    @State private var gaugeValue = 67.0
    #if os(iOS)
    @State private var haptic: SensoryFeedback = .success
    @State private var hapticCount = 0
    #endif

    var body: some View {
        Form {
            Section("Progress") {
                Slider(value: $progress, in: 0...1)
                ProgressView(value: progress)
                ProgressView("Loading…", value: progress)
                HStack {
                    ProgressView()
                        .controlSize(.small)
                    Text("Indeterminate")
                }
            }

            Section("Gauges") {
                Slider(value: $gaugeValue, in: 0...100)
                Gauge(value: gaugeValue, in: 0...100) {
                    Text("CPU")
                } currentValueLabel: {
                    Text("\(Int(gaugeValue))%")
                }
                HStack(spacing: 20) {
                    Gauge(value: gaugeValue, in: 0...100) {
                        Text("CPU")
                    }
                    .gaugeStyle(.accessoryCircular)
                    Gauge(value: gaugeValue, in: 0...100) {
                        Text("CPU")
                    }
                    .gaugeStyle(.accessoryCircularCapacity)
                }
            }

            Section("Labels & Badges") {
                Label("Wi-Fi Connected", systemImage: "wifi")
                Label("Battery Low", systemImage: "battery.25")
                    .foregroundStyle(.orange)
                HStack {
                    Text("Inbox")
                    Spacer()
                    Text("42")
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.red, in: Capsule())
                        .foregroundStyle(.white)
                }
            }

            #if os(iOS)
            Section {
                Button("Success", systemImage: "checkmark.circle") { playHaptic(.success) }
                Button("Warning", systemImage: "exclamationmark.triangle") { playHaptic(.warning) }
                Button("Error", systemImage: "xmark.octagon") { playHaptic(.error) }
                Button("Selection", systemImage: "hand.tap") { playHaptic(.selection) }
                Button("Impact", systemImage: "burst") { playHaptic(.impact) }
            } header: {
                Text("Haptics")
            } footer: {
                Text("Haptics play on iPhone only. iPad and the Simulator have no haptic engine.")
            }
            .sensoryFeedback(trigger: hapticCount) { _, _ in haptic }
            #endif
        }
        .formStyle(.grouped)
    }

    #if os(iOS)
    private func playHaptic(_ feedback: SensoryFeedback) {
        haptic = feedback
        hapticCount += 1
    }
    #endif
}

#Preview {
    FeedbackShowcase()
        .frame(width: 500, height: 700)
}
