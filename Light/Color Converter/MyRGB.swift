import SwiftUI

struct MyRGB: CustomStringConvertible {
    
    var r: Double
    var g: Double
    var b: Double

    var description: String {
        return ("r: " + String(r) + ", g: " + String(g) + ", b: " + String(b))
    }
    
    static func HSV(R: Double, G: Double, B:Double) -> myHSV {
        let Cmax = max(R, G, B)
        let Cmin = min(R, G, B)
        let delta = Cmax - Cmin
        
        var h: Double
        if delta == 0 {
            h = 0
        } else if Cmax == R {
            h = 60 * ((G - B)/delta).truncatingRemainder(dividingBy: 6)
        } else if Cmax == G {
            h = 60 * ((B - R)/delta + 2)
        } else {
            h = 60 * ((R - G)/delta + 4)
        }
        
        let v = Cmax
        
        var s: Double
        if Cmax == 0 {
            s = 0
        } else {
            s = delta/Cmax
        }
        
        if h < 0 {
            h += 360
        }
        
        return  myHSV(h: h, s: s, v: v)
    }
    
    static func HSV(rgb: MyRGB) -> myHSV {
        return HSV(R: rgb.r, G: rgb.g, B: rgb.b)
    }
    
    var hsvValue: myHSV {
        return MyRGB.HSV(rgb: self)
    }
    
    var color: Color { Color(red: r, green: g, blue: b) }
}
