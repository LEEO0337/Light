import SwiftUI

struct EDRSlider: View {
    @Binding var value: Double
    @Binding var EDRMode: Bool
    var range: ClosedRange<Double> = (-0.2 ... 1)
    var step: Double = 0
    
    private var thumbLabel: String {
        value >= 0 ? "HDR" : "SDR"
    }
    
    private var percentage: CGFloat {
        1 - (value - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
    
    private func nearestStepValue(for value: Double) -> Double {
        let steps = round(value / step) * step
        return min(max(steps, range.lowerBound), range.upperBound)
    }
    
    private func snapValueIfNeeded(_ value: Double) -> Double {
        // Snap to -0.2 for SDR
        if value < -0.1 {
            return -0.2
        }
        // Snap to 0 if within 0.1 range (HDR mode)
        else if value > -0.1 && value < 0.1 {
            return 0
        }
        return value
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                // Custom track with a vertical line and horizontal ticks
                VStack (spacing: 0) {
                    // Top tick
                    Rectangle()
                        .frame(width: 15, height: 2)
                    // Middle tick for 0 value
                    Rectangle()
                        .frame(width: 15, height: 2)
                        .padding(.top, geometry.size.height * (1 + range.lowerBound / (range.upperBound - range.lowerBound)))
                    Spacer()
                    // Bottom tick
                    Rectangle()
                        .frame(width: 15, height: 2)
                }
                .foregroundColor(.gray)
                // Vertical line
                Rectangle()
                    .frame(width: 2)
                    .foregroundColor(.gray)
                    
                let height = geometry.size.height
                
                //Thumb Slider
                RoundedRectangle(cornerRadius: 15)
                    .fill(AngularGradient(colors: EDRMode ?  [.red, .yellow, .green, .blue, .purple, .red] : [.white], center: .center))
                    .frame(width: 50, height: 30)
                    .shadow(radius: 10)
                    .overlay(Text(thumbLabel).foregroundColor(EDRMode ? .white : .black))
                    .position(
                        x: geometry.size.width / 2,
                        y: max(min(height * percentage, height), 0)
                    )
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let inversePercentage = 1 - (gesture.location.y / height)
                                let tempValue = inversePercentage * (range.upperBound - range.lowerBound) + range.lowerBound
                                let snappedValue = snapValueIfNeeded(tempValue)
                                let previousValue = self.value  //to see if crossed 0
                                // Apply animation of snaping to 0 when value changes
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    self.value = min(max(snappedValue, range.lowerBound), range.upperBound)
                                }
                                if previousValue < 0 && self.value >= 0 {
                                    HapticManager().triggerFeedback(type: .heavy)
                                    EDRMode = true
                                } else if previousValue >= 0 && self.value < 0 {
                                    HapticManager().triggerFeedback(type: .heavy)
                                    EDRMode = false
                                }
                            }
                    )
            }
        }
        .padding(30)
    }
}

struct EDRSlider_Previews: PreviewProvider {
    @State static private var sliderValue: Double = 0
    
    static var previews: some View {
        EDRSlider(value: $sliderValue, EDRMode: .constant(true))
            .frame(height: 300)
    }
}
