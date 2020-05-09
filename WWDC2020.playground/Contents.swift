import PlaygroundSupport
import UIKit

let scene = SceneController()
let view = UIWindow(frame: CGRect(x: 0, y: 0, width: 760, height: 960))
view.rootViewController = scene
view.makeKeyAndVisible()
PlaygroundPage.current.liveView = view
