import SwiftUI
import SwiftData

@main
struct LightApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().tint(.primary)
        }
        .modelContainer(for: PresetRGB.self)
    }
}
