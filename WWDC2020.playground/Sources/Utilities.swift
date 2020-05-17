import SpriteKit
import SwiftUI

var kPopulationSize: Int = 30

var sprites:[SKLabelNode] = []

var gForce: CGFloat = 10

var gIteration = 0

var virusIncubationTime : Double = 14.0

var animationIsRunning = true

public class dataContainer: ObservableObject {
    @Published var licznik = 1337
}

struct StyleSheet {
        static let backgroundColor: Color = Color(hex: 0x22222c)
        static let textColor: Color = Color(hex: 0x727784)
        static let secondaryTextColor: Color = Color(hex: 0xcfd0d4)
        static let tintColor: Color = Color(hex: 0x6a7586)
        static let barColor: Color = Color(hex: 0x1c1c24)
}


struct AnimationSize {
    static let width : CGFloat = 480
    static let height : CGFloat = 480
}

struct Sums {
    var x = 0   // iteration
    var s = 0   // suspected
    var i = 0   // infected
    var r = 0   // recovered
    var d = 0   // dead
}

struct PhysicsCategory {
    static let None : UInt32 = 0
    static let All  : UInt32 = UInt32.max
    static let Sus  : UInt32 = 0b1  //suspected
    static let Inf  : UInt32 = 0b10 //infected
    static let Rec  : UInt32 = 4    //recovered
    static let Edge : UInt32 = 8
}

func random() -> CGFloat {
    return CGFloat(Double(arc4random()) / 0xFFFFFFFF)
}

func randomRange(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

extension Color {
  init(hex: Int, alpha: Double = 1) {
      let components = (
          R: Double((hex >> 16) & 0xff) / 255,
          G: Double((hex >> 08) & 0xff) / 255,
          B: Double((hex >> 00) & 0xff) / 255
      )
      self.init(
          .sRGB,
          red: components.R,
          green: components.G,
          blue: components.B,
          opacity: alpha
      )
    }
}

extension CGPath {

    var points: Array<CGPoint> {

        var arrPoints: Array<CGPoint> = []

        /// applyWithBlock lets us examine each element of the CGPath, and decide what to do
         
        self.applyWithBlock { element in

            switch element.pointee.type {
            
            case .moveToPoint, .addLineToPoint:
                arrPoints.append(element.pointee.points.pointee)

            case .addQuadCurveToPoint:
              
                arrPoints.append(element.pointee.points.pointee)
                arrPoints.append(element.pointee.points.advanced(by: 1).pointee)

            case .addCurveToPoint:
                
                arrPoints.append(element.pointee.points.pointee)
                arrPoints.append(element.pointee.points.advanced(by: 1).pointee)
                arrPoints.append(element.pointee.points.advanced(by: 2).pointee)

            default:
                break
            }
         }
            
        return arrPoints
    }
}

extension Color {
    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
   
    static let lightStart = Color(red: 240/255, green: 240/255, blue: 246/255)
    static let lightEnd = Color(red: 120/255, green: 120/255, blue: 123/255)
    
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
