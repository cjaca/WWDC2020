import UIKit
import SpriteKit
import SwiftUI
import GameplayKit


public class SceneController: UIViewController {
    
    var sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 760, height: 960))

    override public func viewDidLoad() {
        sceneView.backgroundColor = UIColor.black
        self.view.addSubview(sceneView)
        if let view = self.sceneView as SKView? {
            
            let scene = AnimationViewController(size: CGSize(width: 760, height: 960))
            
            // 1. create an instance of the SwiftUI view we just added to the project
            let dashboardUI = DashboardUIView(animation: scene)
            // 2. embed this view into a ViewController
            let uiController = UIHostingController(rootView: dashboardUI)
            // 3. add the uiController as a child ViewController to this one
            addChild(uiController)
            // 4. set the SwiftUI view controller's frame to be the same size as SpriteKit View
            uiController.view.frame = view.frame
            // 5. set the background color to transparent, otherwise the SwiftUI view contains the standard white background, obscuring the SpriteKit
            uiController.view.backgroundColor = .clear
            // 6. add the SwiftUI view as a subview to the SpriteKit view
            view.addSubview(uiController.view)
            
            
            
            view.presentScene(scene)

            view.ignoresSiblingOrder = true
            

        }
    }
}

