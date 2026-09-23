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

## Platforms

One multiplatform target runs natively on:

- macOS 26.5 or later
- iOS and iPadOS 26.0 or later

Each platform shows its own native controls. Where a control exists only on macOS, such as the checkbox toggle or radio group picker, iPhone and iPad show the iOS equivalent with a note underneath. Some sections exist only on iPhone and iPad, such as swipe actions, wheel pickers, haptics and pointer hover effects.

Foundation Models needs a device with Apple Intelligence turned on; the screen reports when the model is unavailable.

## Requirements

- Xcode
- Swift / SwiftUI

## Build & Run

Open `AppleShowcase.xcodeproj` in Xcode, select a run destination (My Mac, an iPhone or iPad simulator, or a device), and press ⌘R. To run on a physical device, pick your team under Signing & Capabilities first.
