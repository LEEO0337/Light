import SwiftUI

struct ContentView: View {
    
    @State public var RGBValue = MyRGB(r: 255/255, g: 238/255, b: 227/255)
    @State public var HSVValue = myHSV(h: 0, s: 0, v: 0)
    @State public var wbValue = 5600
    
    @State private var fullScreen = false
    @State private var isEDRMode = false
    @State private var EDRValue = -0.2
    
    @State private var selectedTab = Tabs.WB
    
    private enum Tabs: String {
        case WB = "WB"
        case RGB = "RGB"
        case HSV = "HSV"
        case Presets = "Presets"
    }
    
    var body: some View {
        
        VStack {
            if !fullScreen { Spacer(minLength: 100) }
            HStack {
                
                Spacer()
                
                Button(action: { withAnimation(.spring(duration: 0.3)) { fullScreen.toggle() } }) {
                    //EDR Mode
                    if isEDRMode { EDRView(RGBValue: $RGBValue, EDRValue: $EDRValue) }
                    //SDR Mode
                    else { RoundedRectangle(cornerRadius: fullScreen ? 0 : 40).foregroundColor(RGBValue.color) }
                }
                .clipShape(RoundedRectangle(cornerRadius: fullScreen ? 0 : 40))
                .aspectRatio(contentMode: fullScreen ? .fill : .fit)
                .padding(.leading, fullScreen ? 0 : 80)
                .shadow(radius: 10)
                
                Spacer()
                
                if !fullScreen {
                    EDRSlider(value: $EDRValue, EDRMode: $isEDRMode)
                        .frame(width: 80)
                }
            }
            .ignoresSafeArea()
            
            if !fullScreen {
                VStack {
                    Spacer()
                    TabView(selection: $selectedTab) {
                        WBView(RGBValue: $RGBValue, wbValue: $wbValue)
                            .tabItem { Text("WB") }
                            .tag(Tabs.WB)
                            .onDisappear() { if !fullScreen { HSVValue = RGBValue.hsvValue } }
                        
                        RGBView(RGBValue: $RGBValue)
                            .tabItem { Text("RGB") }
                            .tag(Tabs.RGB)
                            .onDisappear() { if !fullScreen { HSVValue = RGBValue.hsvValue } }
                        
                        HSVView(HSVValue: $HSVValue)
                            .tabItem { Text("HSV") }
                            .tag(Tabs.HSV)
                            .onDisappear() { if !fullScreen { RGBValue = HSVValue.rgbValue } }
                            .onChange(of: HSVValue) { RGBValue = HSVValue.rgbValue }
                        
//                        PresetsView(RGBValue: $RGBValue)
//                            .tabItem { Text("Presets") }
//                            .tag(Tabs.Presets)
//                            .onDisappear() { if !fullScreen { HSVValue = RGBValue.hsvValue } }
                    }
                    .frame(height: 400)
                }
            }
        }
    }
}

#Preview {
    ContentView(RGBValue: MyRGB(r: 1, g: 1, b: 1), HSVValue: myHSV(h: 0.3, s: 0.8, v: 0.5), wbValue: 5600)
}
