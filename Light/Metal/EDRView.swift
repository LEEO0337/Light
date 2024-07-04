import SwiftUI
import CoreImage

struct EDRView: View {
    
    @Binding var RGBValue: MyRGB
    @Binding var EDRValue: Double
    
    var body: some View {
        // Create a Metal view with its own renderer.
        let renderer = Renderer(imageProvider: { (time: CFTimeInterval, scaleFactor: CGFloat, headroom: CGFloat) -> CIImage in
            let brightness = max(EDRValue * headroom, 1)
            return CIImage(color: CIColor(
                red: brightness * CGFloat(RGBValue.r),
                green: brightness * (RGBValue.g),
                blue: brightness * CGFloat(RGBValue.b),
                colorSpace: CGColorSpace(name: CGColorSpace.extendedLinearSRGB)!)!)
        })
        
        MetalView(renderer: renderer).ignoresSafeArea()
    }
}

#Preview {
    EDRView(RGBValue: .constant(MyRGB(r: 1, g: 1, b: 1)), EDRValue: .constant(1))
}
