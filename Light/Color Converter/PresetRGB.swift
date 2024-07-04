import SwiftUI
import Foundation
import SwiftData

@Model
class PresetRGB: Identifiable {
    
    var id: String
    var r: Double
    var g: Double
    var b: Double
    
    init(r: Double, g: Double, b: Double) {
        self.id = UUID().uuidString
        self.r = r
        self.g = g
        self.b = b
    }
    
    init(rgb: MyRGB) {
        self.id = UUID().uuidString
        self.r = rgb.r
        self.g = rgb.g
        self.b = rgb.b
    }
    
    var myRGB: MyRGB { MyRGB(r: r, g: g, b: b) }
    
    var color: Color { Color(red: r, green: g, blue: b) }
}
