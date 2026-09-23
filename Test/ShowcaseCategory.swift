//
//  ShowcaseCategory.swift
//  Test
//

import SwiftUI

enum ShowcaseCategory: String, CaseIterable, Identifiable {
    case buttons
    case selection
    case dataEntry
    case feedback
    case dataDisplay
    case menus
    case foundationModels

    var id: Self { self }

    var title: String {
        switch self {
        case .buttons: "Buttons"
        case .selection: "Toggles & Selection"
        case .dataEntry: "Data Entry"
        case .feedback: "Feedback & Status"
        case .dataDisplay: "Data Display"
        case .menus: "Menus & Presentations"
        case .foundationModels: "Foundation Models"
        }
    }

    var symbol: String {
        switch self {
        case .buttons: "rectangle.and.hand.point.up.left"
        case .selection: "switch.2"
        case .dataEntry: "textformat"
        case .feedback: "gauge.with.dots.needle.67percent"
        case .dataDisplay: "tablecells"
        case .menus: "menucard"
        case .foundationModels: "apple.intelligence"
        }
    }
}
