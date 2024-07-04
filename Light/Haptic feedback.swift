import SwiftUI

class HapticManager {
    static let instance = HapticManager()
    
    func triggerFeedback(type: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: type)
        generator.prepare()
        generator.impactOccurred()
    }
}
