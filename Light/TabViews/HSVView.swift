import SwiftUI

struct HSVView: View {
    
    @Binding var HSVValue: myHSV
    
    var body: some View {
        
        let hueColors = (0...10).map { Color(hue: Double($0) * 0.1, saturation: 1, brightness: 1) }
        
        VStack {
            Spacer()
            
            GradientSlider(value: $HSVValue.h, colors: hueColors, range: 0...360, thumbLabel: "H")
            
            GradientSlider(value: $HSVValue.s, colors: [
                Color(hue: HSVValue.h/360, saturation: 0, brightness: 1),
                Color(hue: HSVValue.h/360, saturation: 1, brightness: 1)
            ], range: 0...1, thumbLabel: "S")
            
            GradientSlider(value: $HSVValue.v, colors: [
                Color(hue: HSVValue.h/360, saturation: HSVValue.s, brightness: 0),
                Color(hue: HSVValue.h/360, saturation: HSVValue.s, brightness: 1)
            ], range: 0...1, thumbLabel: "V")
                
        }
    }
}

#Preview {    
    HSVView(HSVValue: .constant(myHSV(h: 0, s: 1, v: 1)))
}
