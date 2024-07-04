import SwiftUI

struct myHSV: CustomStringConvertible, Equatable {
    
    var h: Double
    var s: Double
    var v: Double
    
    init(h: Double, s: Double, v: Double) {
        self.h = h
        self.s = s
        self.v = v
    }
    
    var description: String {
        return ("h: " + String(self.h) + ", s: " + String(self.s) + ", v: " + String(self.v))
    }
    
    static func ==(lhs: myHSV, rhs: myHSV) -> Bool {
        return lhs.h == rhs.h && lhs.s == rhs.s && lhs.v == rhs.v
    }
    
    static func RGB(h: Double, s: Double, v: Double) -> MyRGB {
        let C = v * s
        let X = C * (1-abs((h/60).truncatingRemainder(dividingBy: 2) - 1))
        let m = v - C
        
        var result: MyRGB
        switch h {
        case 0 ..< 60:
            result = MyRGB(r: C, g: X, b: 0)
        case 60..<120:
            result = MyRGB(r: X, g: C, b: 0)
        case 120..<180:
            result = MyRGB(r: 0, g: C, b: X)
        case 180..<240:
            result = MyRGB(r: 0, g: X, b: C)
        case 240..<300:
            result = MyRGB(r: X, g: 0, b: C)
        case 300...360:
            result = MyRGB(r: C, g: 0, b: X)
        default:
            return MyRGB(r: 0, g: 0, b: 0)
        }
        
        return MyRGB(r: result.r + m, g: result.g + m, b: result.b + m)
    }
    
    static func RGB(hsv: myHSV) -> MyRGB {
        return RGB(h: hsv.h, s: hsv.s, v: hsv.v)
    }
    
    var rgbValue: MyRGB {
        return myHSV.RGB(hsv: self)
    }
    
    var color: Color { Color(hue: self.h/360, saturation: self.s, brightness: self.v)}
}

