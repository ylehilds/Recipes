# Recipes (iOS)

A native iOS app for **browsing, viewing, and organizing cooking recipes**. The app provides a simple list → detail flow where users can explore a collection of recipes, view details such as ingredients and instructions, and manage their own favorites or custom entries.

This project demonstrates clean iOS app structure, Swift best practices, and separation of concerns with dedicated unit and UI test targets.

---

## ✨ What the App Does

- **Browse Recipes**  
  View a scrollable list of recipes with their names, categories.

- **Recipe Details**  
  Tap into a recipe to see a dedicated detail view with:
    - Ingredients list
    - Step-by-step instructions
    - Optional nutritional information

- **Favorites / Collections**  
  Mark recipes as favorites for quick access.

- **Add or Edit Recipes**  
  Create your own recipes or modify existing ones for personal use.

- **Testing Support**  
  Includes `RecipesTests` for unit testing logic and `RecipesUITests` for validating UI flows.

---

## 🛠 Tech Stack

- **Language:** Swift
- **Frameworks:** UIKit or SwiftUI (depending on your implementation), Foundation
- **IDE:** Xcode (recommended Xcode 15 or newer)
- **iOS SDK:** iOS 15+ (configurable in project settings)
- **Testing:** XCTest (Unit Tests), XCUITest (UI Tests)
- **Dependency Management:** Swift Package Manager (SPM)
- **3rd-party Libraries:**
  - [MarkdownUI](https://github.com/gonzalezreal/MarkdownUI) — render recipe instructions and content written in Markdown
---

## Project Structure

```
Recipes/                 # App source (views, models, view models/controllers, resources)
Recipes.xcodeproj        # Xcode project
RecipesTests/            # Unit tests (XCTest)
RecipesUITests/          # UI tests (XCUITest)
.gitignore
LICENSE                  # MIT
README.md
```
---

## Getting Started

### Prerequisites
- **Xcode 15+**
- **iOS 15+** simulator or device (adjust as needed)

### Clone & Open
```bash
git clone https://github.com/ylehilds/Recipes.git
cd Recipes
open Recipes.xcodeproj
```

### Build & Run
- Select the **Recipes** scheme.
- Choose an iOS Simulator (e.g., iPhone 15).
- Press **Run** (⌘R).

### Run Tests
- **All tests in Xcode:** Product → Test (⌘U)
- **CLI (xcodebuild):**
```bash
xcodebuild -scheme Recipes -destination 'platform=iOS Simulator,name=iPhone 15' build test
```

---

## Screenshots

TODO: Add 1–3 small screenshots or a GIF of the app running.

```
/Screenshots/
  list.png
  detail.png
  favorites.png
```

---

## Roadmap

- [ ] Remote data source (REST/GraphQL) with image caching

---

## Contributing

PRs welcome! Please open an issue first to discuss major changes. Be sure to update tests as appropriate.

---

## License

This project is licensed under the **MIT License** — see [`LICENSE`](LICENSE) for details.

---

## Contact

Have questions or suggestions?  
**Lehi Alcantara** — [lehi.dev](https://www.lehi.dev) • lehi@lehi.dev
