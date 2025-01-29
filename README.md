# IndicatorSegmentedControl

`IndicatorSegmentedControl` is a custom UI component for iOS that provides a tab control with an animated indicator.

![Demo](https://raw.githubusercontent.com/MichaelRoma/IndicatorSegmentedControl/main/demo.gif)

## 📦 Installation

You can install this package via **Swift Package Manager**:

1. Open **Xcode > File > Add Packages...**
2. Enter the repository URL:  
   ```
   https://github.com/MichaelRoma/IndicatorSegmentedControl.git
   ```
3. Select version `1.0.2` and install.

Or manually add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/MichaelRoma/IndicatorSegmentedControl.git", from: "1.0.2")
]
```

## 🚀 Usage

### 1️⃣ **Creating the Tab Control**
```swift
import IndicatorSegmentedControl

let tabs = ["Item1", "Item2", "Item3", "Item4"]
let segmentedControl = IndicatorSegmentedControl(tabs: tabs)

segmentedControl.valueChangeAction = { selectedIndex in
    print("Selected tab: \(selectedIndex)")
}
```

### 2️⃣ **Adding to UI**
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    let segmentedControl = IndicatorSegmentedControl(tabs: ["Item1", "Item2", "Item3", "Item4"])
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(segmentedControl)

    NSLayoutConstraint.activate([
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        segmentedControl.heightAnchor.constraint(equalToConstant: 44)
    ])
}
```
## 🛠 Requirements
- iOS 13.0+
- Swift 5.7+
- Xcode 14+

---

## 📄 License
This project is released under the [MIT](LICENSE) license.
