//
//  FeedbackShowcase.swift
//  Test
//

import SwiftUI

struct FeedbackShowcase: View {
    @State private var progress = 0.4
    @State private var gaugeValue = 67.0

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
        }
        .formStyle(.grouped)
    }
}

#Preview {
    FeedbackShowcase()
        .frame(width: 500, height: 700)
}
