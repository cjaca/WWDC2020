import SpriteKit
import GameplayKit
import UIKit
import SwiftUI

public class AnimationViewController: SKScene, SKPhysicsContactDelegate, ObservableObject {
    
    @Published var deadEmojis = 0
    
    @Published var gameIsPaused = false {
        didSet {
            isPaused = gameIsPaused
        }
    }
    
    override public func didMove(to view: SKView) {
        // View size
        super.size = CGSize(width: 760, height: 960)
        super.anchorPoint = CGPoint(x:0, y: 0)
        super.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        super.physicsWorld.contactDelegate = self
        super.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        view.allowsTransparency = true
    
        
        // Creating bounds
        let rect = CGRect(x: 25, y: 505, width: 710, height: 430)
        let visibleRect = SKShapeNode(rectOf: CGSize(width: 710, height: 430))
        visibleRect.fillColor = .white
        visibleRect.strokeColor = UIColor(red: 0.22, green: 0.24, blue: 0.25, alpha: 1.00)
        visibleRect.glowWidth = CGFloat(1)
        visibleRect.position = CGPoint(x: 380, y: 720)
        addChild(visibleRect)
        //let circle = CGPath(ellipseIn: rect, transform: nil)
        let edge = SKPhysicsBody(edgeLoopFrom: rect)
        edge.categoryBitMask = PhysicsCategory.Edge
        edge.contactTestBitMask = PhysicsCategory.All
        edge.collisionBitMask = PhysicsCategory.All
        super.physicsBody = edge
        
        initSprites()
        popSummary()
        startInfection()
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        // If both masks are the same, skip.
        if contact.bodyA.categoryBitMask == contact.bodyB.categoryBitMask { return }
        
        // If A(sus) collide with B(Infected) - B++ hasInfected, A goes to healOrDie
        if contact.bodyA.categoryBitMask == PhysicsCategory.Sus && contact.bodyB.categoryBitMask == PhysicsCategory.Inf{
            popSummary()
            let infectiousNode = contact.bodyB.node as! SKLabelNode
            var hasInfected = infectiousNode.userData?.value(forKey: "keyHasInfected") as! Int
            hasInfected += 1
            infectiousNode.userData?.setValue(hasInfected, forKey: "keyHasInfected")
            
            let node = contact.bodyA.node as! SKLabelNode
            healOrDie(node: node)
        }
        
        // If B collide with A
        if contact.bodyB.categoryBitMask == PhysicsCategory.Sus && contact.bodyA.categoryBitMask == PhysicsCategory.Inf {
            popSummary()
            let infectiousNode = contact.bodyA.node as! SKLabelNode
            var hasInfected = infectiousNode.userData?.value(forKey: "keyHasInfected") as! Int
            hasInfected += 1
            infectiousNode.userData?.setValue(hasInfected, forKey: "keyHasInfected")
            
            let node = contact.bodyB.node as! SKLabelNode
            node.physicsBody?.categoryBitMask = PhysicsCategory.Inf
            node.text = String("😷")
            healOrDie(node: node)
        }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if animationIsRunning {
            gIteration += 1
            applyForceToSprite()
        }
    }
}

extension AnimationViewController {
    func initSprites() {
        sprites = spritesCollection(count: kPopulationSize)
        for sprite in sprites {
            addChild(sprite)
        }
    }

    func spritesCollection(count: Int) -> [SKLabelNode] {
         
         var i = 0
         for _ in 0..<count {
             // Set emoji
             let sprite = SKLabelNode(text: String("😊"))
            // Set name based on next number
             sprite.name = String(i)
            // Center of sprite
             sprite.verticalAlignmentMode = .center
             sprite.horizontalAlignmentMode = .center
             
            // Setting spawn
             let x = randomRange(min: 25, max: 735)
             let y = randomRange(min: 505, max: 935)
             sprite.position = CGPoint(x: x, y: y)
             
            // Setting physics of emoji
             sprite.physicsBody = SKPhysicsBody(circleOfRadius: 10)
             sprite.physicsBody?.isDynamic = true
             sprite.physicsBody?.allowsRotation = true
             sprite.physicsBody?.affectedByGravity = false
             sprite.physicsBody?.mass = 0.01
             
            // Setting bit masks
             sprite.physicsBody!.categoryBitMask = PhysicsCategory.Sus
             sprite.physicsBody!.contactTestBitMask = PhysicsCategory.All
             sprite.physicsBody?.collisionBitMask = PhysicsCategory.All
             
             sprite.physicsBody?.usesPreciseCollisionDetection = true
             
            // Apply start velocity
             let actualX = randomRange(min: -100, max: 100)
             let actualY = randomRange(min: -100, max: 100)
             sprite.physicsBody?.velocity = CGVector(dx: actualX, dy: actualY)
             sprite.physicsBody?.friction = 0
             sprite.physicsBody?.restitution = 1
             
             sprite.blendMode = .replace
             sprite.userData = [
                 "keyInfectedDate" : 0,
                 "keyHealedDate" : 0,
                 "keyDeathDate" : 0,
                 "keyHasInfected" : 0
             ]
             
             sprites.append(sprite)
             i+=1
         }
         return sprites
     }
     
    func applyForceToSprite(){
         
         // Determine force
         let actualX = randomRange(min: -gForce, max: gForce)
         let actualY = randomRange(min: -gForce, max: gForce)
         
         // Pick random sprite
         let max = CGFloat(kPopulationSize-1)
         let i = Int(randomRange(min: 0, max: max).rounded())
         let s = sprites[i]
         
         // ignore the dead
         if s.physicsBody?.categoryBitMask == PhysicsCategory.None {return}
         
        // Apply force to alive
         s.physicsBody?.applyForce(CGVector(dx: actualX, dy: actualY))
     }


    // Makes summary of emojis
    func popSummary() {
        
        var sSum = 0, iSum = 0, rSum = 0
        
        for sprite in sprites {
            if sprite.physicsBody?.categoryBitMask == PhysicsCategory.Sus {
                sSum += 1
            }
            else if sprite.physicsBody?.categoryBitMask == PhysicsCategory.Rec {
                rSum += 1
            }
            else if sprite.physicsBody?.categoryBitMask == PhysicsCategory.Inf {
                iSum += 1
            }
        }
        
        let total = sSum + iSum + rSum
        let dead = kPopulationSize - total
        deadEmojis = dead
        let sumElement = Sums(x: gIteration, s: sSum, i: iSum, r: rSum, d: dead)
        sir.append(sumElement)
    }

    func healOrDie(node: SKLabelNode) {
        // sets node to infected state
        node.physicsBody?.categoryBitMask = PhysicsCategory.Inf
        node.text = String("🤢")
        node.userData?.setValue(gIteration, forKey: "keyInfectedDate")
        
        let _ = Timer.scheduledTimer(withTimeInterval: virusIncubationTime, repeats: false) {
            timer in
            
            // probability of spreading the virus
            let probability = randomRange(min: 0, max: 100)
            
            if probability < 10 {
                node.userData?.setValue(gIteration, forKey: "keyDeathDate")
                node.physicsBody?.categoryBitMask = PhysicsCategory.None
                node.physicsBody?.contactTestBitMask = PhysicsCategory.None
                node.physicsBody?.collisionBitMask = PhysicsCategory.None
                self.popSummary()
                node.text = String("☠️")
                // Stuck him in place
                node.physicsBody?.velocity = CGVector()
            } else {
                // Healed patient
                node.userData?.setValue(gIteration, forKey: "keyHealedDate")
                node.physicsBody?.categoryBitMask = PhysicsCategory.Rec
                node.text = String("🤩")
                self.popSummary()
            }
        }
    }

    func startInfection() {
        // start infection
        let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            let max = CGFloat(kPopulationSize-1)
            let i = Int(randomRange(min:0, max: max).rounded())
            
            for sprite in sprites {
                if sprite.name == String(i) {
                    let node = sprites[i]
                    self.healOrDie(node: node)
                }
            }
        }
    }
}
