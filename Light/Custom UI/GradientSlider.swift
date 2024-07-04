import SwiftUI

struct GradientSlider: View {
    
    @Binding var value: Double
    var colors: [Color]
    var range: ClosedRange<Double>
    var step: Double = 0
    var thumbLabel: String
    
    @State var previousValue: Double? = nil
    @State var isDragging = false
    
    private var percentage: CGFloat {
        CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
    }
    
    private func nearestStepValue(for value: Double) -> Double {
        let steps = round(value / step) * step
        return min(max(steps, range.lowerBound), range.upperBound)
    }
    
    var body: some View {
        
        let cornerRadius: CGFloat = 15
        
        GeometryReader { geometry in
            ZStack {
                // Gradient track
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
                    .frame(height: 30) // Track height
                
                let width = geometry.size.width - cornerRadius * 2
                
                // Custom thumb with label
                
                Circle()
                    .frame(height: isDragging ? 45 : 30) // Thumb size
                    .animation(.spring, value: isDragging)
                    .foregroundColor(.white.opacity(0.8))
                    .shadow(radius: 10)
                    .overlay(Text(thumbLabel).foregroundColor(.black))
                    .position(
                        x: max(min(width * percentage, width), 0) + cornerRadius,
                        y: geometry.size.height / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { v in
                                isDragging = true
                                value = min(max(Double(v.location.x / width) * (range.upperBound - range.lowerBound) + range.lowerBound, range.lowerBound), range.upperBound)
                                if step > 0 {
                                    value = nearestStepValue(for: value)
                                    if value != previousValue {
                                        HapticManager().triggerFeedback(type: .soft)
                                        previousValue = value
                                    }
                                }
                            }
                            .onEnded { _ in isDragging = false}
                    )
            }
        }
        .frame(height: 40)
        .padding(15)
    }
}

struct GradientSlider_Previews: PreviewProvider {
    @State static private var sliderValue: Double = 0.3
    
    static var previews: some View {
        GradientSlider(value: $sliderValue, colors: [.red, .blue, .red], range: 0...1, thumbLabel: "R")
    }
}
