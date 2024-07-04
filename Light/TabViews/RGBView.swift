import SwiftUI

struct RGBView: View {
    
    @Binding var RGBValue: MyRGB
    
    var body: some View {
        VStack {
            Spacer()
            
            GradientSlider(value: $RGBValue.r, colors: [
                Color(red: 0, green: RGBValue.g, blue: RGBValue.b),
                Color(red: 1, green: RGBValue.g, blue: RGBValue.b)
            ], range: 0...1, thumbLabel: "R")
            
            GradientSlider(value: $RGBValue.g, colors: [
                Color(red: RGBValue.r, green: 0, blue: RGBValue.b),
                Color(red: RGBValue.r, green: 1, blue: RGBValue.b)
            ], range: 0...1, thumbLabel: "G")
        
            GradientSlider(value: $RGBValue.b, colors: [
                Color(red: RGBValue.r, green: RGBValue.g, blue: 0),
                Color(red: RGBValue.r, green: RGBValue.g, blue: 1)
            ], range: 0...1, thumbLabel: "B")
        }
    }
}

#Preview {
    RGBView(RGBValue: .constant(MyRGB(r: 255/255, g: 238/255, b: 227/255)))
}
