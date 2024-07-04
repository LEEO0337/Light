import SwiftUI
import SwiftData

struct PresetsView: View {
    
    @Binding var RGBValue: MyRGB
    
    @Environment(\.modelContext) private var context
    @Query private var presets: [PresetRGB]
    
    @State private var deletingPresetID: String? = nil
    
    private func isEditable() -> Bool {
        return presets.count < 12
    }
    
    var body: some View {
        VStack{
            LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
                ForEach(presets) { preset in
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 70, height: 70)
                        .foregroundColor(preset.color)
                        .scaleEffect(deletingPresetID == preset.id ? 0.1 : 1)
                    
                        .onTapGesture {
                            RGBValue = preset.myRGB
                        }
                        
                        .onLongPressGesture() {
                            withAnimation(.easeIn(duration: 0.2)) {
                                deletingPresetID = preset.id
                            }
                            // Delay to allow animation to complete before deletion
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                deleteColor(preset)
                                deletingPresetID = nil
                            }
                        }
                        .animation(.easeInOut(duration: 0.3), value: presets)
                }
                
                // Add new preset button if less than 12 presets
                if isEditable() {
                    Button(action: { addNewPreset() }) {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 70, height: 70)
                            .foregroundColor(Color.gray)
                            .overlay(
                                Text("+")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            )
                    }
                    .animation(.easeInOut(duration: 0.3), value: presets)
                }
            }
            Spacer()
        }
    }
    
    private func addNewPreset() {
        context.insert(PresetRGB(rgb: RGBValue))
    }
    
    private func deleteColor(_ color: PresetRGB) {
        context.delete(color)
    }
    
}

#Preview {
    PresetsView(RGBValue: .constant(MyRGB(r: 0.5, g: 0.5, b: 0.5)))
}
