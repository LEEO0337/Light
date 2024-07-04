import SwiftUI

struct WBButtonData {
    let wbValue: Int
    let icon: (Color) -> AnyView
}

let wbPresets = [
    WBButtonData(wbValue: 3200, icon: { color in AnyView(TungstenIcon(color: color)) }),
    WBButtonData(wbValue: 4000, icon: { color in AnyView(FluorescentIcon(color: color)) }),
    WBButtonData(wbValue: 5600, icon: { color in AnyView(DaylightIcon(color: color)) }),
    WBButtonData(wbValue: 6500, icon: { color in AnyView(CloudyIcon(color: color)) }),
    WBButtonData(wbValue: 7000, icon: { color in AnyView(ShadeIcon(color: color)) })
]


struct WBView: View {
    
    @Binding var RGBValue: MyRGB
    @Binding var wbValue: Int
    
    func updateRGBValue() {
        RGBValue = kelvinToRGB[wbValue] ?? MyRGB(r: 0.0, g: 0.0, b: 0.0)
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach (wbPresets, id: \.wbValue) { wbPreset in
                    wbPreset.icon(wbPreset.wbValue == wbValue ? .primary : .gray)
                    .frame(maxWidth: 60)
                    .padding(.horizontal, 15)
                    .onTapGesture {
                        wbValue = wbPreset.wbValue
                        updateRGBValue()
                        HapticManager().triggerFeedback(type: .medium)
                    }
                    
                    if wbPreset.wbValue != wbPresets.last?.wbValue { Spacer() }
                }
            }
            .padding(.vertical, 30)
            
            GradientSlider(value: Binding(
                get: { Double(wbValue) },
                set: { newValue in
                    wbValue = Int(newValue)
                    updateRGBValue()}), colors: kelvinToRGB
                .sorted(by: { $0.key < $1.key })
                .enumerated()
                .map { _, keyValue in keyValue.value.color }, range: 2500...8000, step: 100, thumbLabel: "")
            
            Text(String(wbValue))
            
        }
    }
}

#Preview {
    WBView(RGBValue: .constant(MyRGB(r: 0, g: 0.5, b: 0)), wbValue: .constant(5600))
}
