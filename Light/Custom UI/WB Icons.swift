import SwiftUI

struct FluorescentIcon: View {
    var color: Color = .primary
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let lineWidth = size / 15
            ZStack {
                RoundedRectangle(cornerRadius: size / 15)
                    .aspectRatio(4, contentMode: .fit)
                    .padding(.horizontal, size / 20)
                ForEach(0..<8) { i in
                    if (i % 4 != 2) {
                        RoundedRectangle(cornerRadius: .infinity)
                            .frame(width: lineWidth, height: size / 5)
                            .offset(y: size / 2.4)
                            .rotationEffect(.degrees(Double(i) * 45))
                    }
                }
            }
            .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height))
        }
        .foregroundColor(color)
    }
}

struct DaylightIcon: View {
    var color: Color = .primary
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: "sun.max.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height))
        }
    }
}

struct CloudyIcon: View {
    var color: Color = .primary
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: "cloud.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height))
        }
    }
}

struct ShadeIcon: View {
    var color: Color = .primary
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: "house")
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height))
        }
    }
}

struct TungstenIcon: View {
    var color: Color = .primary
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let lineWidth = size / 15
            ZStack {
                RoundedRectangle(cornerRadius: size / 20)
                    .frame(width: size / 4, height: size / 3)
                    .offset(CGSize(width: 0, height: -size / 4))
                Circle()
                    .frame(width: size / 2)
                ForEach(0..<9) { i in
                    if (i < 4 || i > 5) {
                        RoundedRectangle(cornerRadius: .infinity)
                            .frame(width: lineWidth, height: size / 5)
                            .offset(y: size / 2.4)
                            .rotationEffect(.degrees(Double(i) * 40))
                    }
                }
            }
            .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height))
        }
        .foregroundColor(color)
    }
}

#Preview {
    TungstenIcon()
        .frame(width: 100, height: 100)
}
