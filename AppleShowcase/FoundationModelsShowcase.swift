//
//  FoundationModelsShowcase.swift
//  AppleShowcase
//

import SwiftUI
import FoundationModels

@Generable
struct Recipe {
    @Guide(description: "A short, appetizing title for the dish")
    var title: String
    @Guide(description: "The ingredients needed", .count(4))
    var ingredients: [String]
    @Guide(description: "Numbered preparation steps", .count(3))
    var steps: [String]
}

struct FoundationModelsShowcase: View {
    private let model = SystemLanguageModel.default
    @State private var session = LanguageModelSession()

    @State private var prompt = "Write a two-sentence bedtime story about a robot."
    @State private var response = ""
    @State private var isResponding = false

    @State private var streamedText = ""
    @State private var isStreaming = false

    @State private var recipe: Recipe?
    @State private var isGeneratingRecipe = false

    @State private var errorMessage: String?

    var body: some View {
        Form {
            Section("Availability") {
                availabilityRow
            }

            Section("Free-Form Prompt") {
                TextField("Prompt", text: $prompt, axis: .vertical)
                    .lineLimit(2...4)
                Button("Ask", systemImage: "text.bubble") {
                    ask()
                }
                .disabled(!model.isAvailable || isResponding)
                if isResponding {
                    ProgressView()
                } else if !response.isEmpty {
                    Text(response)
                        .foregroundStyle(.secondary)
                }
            }

            Section("Streaming Response") {
                Button("Stream a Story", systemImage: "text.append") {
                    stream()
                }
                .disabled(!model.isAvailable || isStreaming)
                if !streamedText.isEmpty || isStreaming {
                    Text(streamedText)
                        .foregroundStyle(.secondary)
                }
            }

            Section("Guided Generation") {
                Button("Generate a Recipe", systemImage: "fork.knife") {
                    generateRecipe()
                }
                .disabled(!model.isAvailable || isGeneratingRecipe)
                if isGeneratingRecipe {
                    ProgressView()
                } else if let recipe {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(recipe.title)
                            .font(.headline)
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            Label(ingredient, systemImage: "circle.fill")
                                .labelStyle(.titleOnly)
                                .foregroundStyle(.secondary)
                        }
                        ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                            Text("\(index + 1). \(step)")
                        }
                    }
                }
            }
        }
        .formStyle(.grouped)
        .alert("Something Went Wrong", isPresented: errorBinding) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage ?? "")
        }
    }

    @ViewBuilder
    private var availabilityRow: some View {
        switch model.availability {
        case .available:
            Label("On-device model is available", systemImage: "checkmark.circle.fill")
                .foregroundStyle(.green)
        case .unavailable(.deviceNotEligible):
            Label("This device doesn't support Apple Intelligence", systemImage: "xmark.circle.fill")
                .foregroundStyle(.red)
        case .unavailable(.appleIntelligenceNotEnabled):
            Label("Enable Apple Intelligence in Settings", systemImage: "exclamationmark.circle.fill")
                .foregroundStyle(.orange)
        case .unavailable(.modelNotReady):
            Label("Model assets are downloading", systemImage: "arrow.down.circle")
                .foregroundStyle(.orange)
        case .unavailable:
            Label("Model is unavailable", systemImage: "xmark.circle.fill")
                .foregroundStyle(.red)
        }
    }

    private var errorBinding: Binding<Bool> {
        Binding(get: { errorMessage != nil }, set: { if !$0 { errorMessage = nil } })
    }

    private func ask() {
        response = ""
        isResponding = true
        Task {
            defer { isResponding = false }
            do {
                let result = try await session.respond(to: prompt)
                response = result.content
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    private func stream() {
        streamedText = ""
        isStreaming = true
        Task {
            defer { isStreaming = false }
            do {
                let stream = session.streamResponse(to: "Tell a short, whimsical story about a lighthouse keeper.")
                for try await snapshot in stream {
                    streamedText = snapshot.content
                }
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    private func generateRecipe() {
        recipe = nil
        isGeneratingRecipe = true
        Task {
            defer { isGeneratingRecipe = false }
            do {
                let result = try await session.respond(
                    to: "Create a simple, healthy dinner recipe.",
                    generating: Recipe.self
                )
                recipe = result.content
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    FoundationModelsShowcase()
        .frame(width: 500, height: 700)
}
