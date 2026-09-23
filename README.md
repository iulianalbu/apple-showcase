# AppleShowcase

A SwiftUI app showcasing Apple platform UI components and APIs, organized by category with a searchable sidebar.

## Structure

| File | Purpose |
| --- | --- |
| `AppleShowcase/AppleShowcaseApp.swift` | App entry point (`@main`), hosts `ContentView` in a `WindowGroup` |
| `AppleShowcase/ContentView.swift` | Sidebar navigation with search, badges, and detail toolbar |
| `AppleShowcase/ShowcaseCategory.swift` | Category definitions used to drive navigation |
| `AppleShowcase/ButtonsShowcase.swift` | Button styles and variants |
| `AppleShowcase/DataDisplayShowcase.swift` | Data display components |
| `AppleShowcase/DataEntryShowcase.swift` | Data entry controls |
| `AppleShowcase/FeedbackShowcase.swift` | Feedback UI (alerts, progress, etc.) |
| `AppleShowcase/MenusNavigationShowcase.swift` | Menus and navigation components |
| `AppleShowcase/SelectionControlsShowcase.swift` | Selection controls (pickers, toggles, etc.) |
| `AppleShowcase/FoundationModelsShowcase.swift` | Foundation Models framework examples |
| `AppleShowcase/Assets.xcassets` | App icons and colors |

## Requirements

- Xcode
- Swift / SwiftUI

## Build & Run

Open `AppleShowcase.xcodeproj` in Xcode, select a run destination, and press ⌘R.
