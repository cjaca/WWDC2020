import SpriteKit

let kPopulationSize: Int = 30

var sprites:[SKLabelNode] = []

var gForce: CGFloat = 50

var gIteration = 0

var sir: [Sums] = []

var virusIncubationTime : Double = 14.0

var animationIsRunning = true

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
