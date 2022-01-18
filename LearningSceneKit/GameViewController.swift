//
//  GameViewController.swift
//  LearningSceneKit
//
//  Created by abhishek chaudhary on 11/01/22.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene()
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.white
        
        
        //My cutom geometry
        VirtualPushButton()
        addSafetyGeometry()
        addLeftSidescreenGeometry()
        addRightSidescreenGeometry()
        ObjectCube()
        SensorCube()
        Grid()
        Circle()
        Cone()
        
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.white
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    func addSafetyGeometry() {
        let vertices: [SCNVector3] = [
            SCNVector3(0.85, 2.20, 0.05),   // Front-top-right
            SCNVector3(-0.85, 2.20, 0.05),  // Front-top-left
            SCNVector3(0.85, 2.20, -0.45),  // Back-top-right
            SCNVector3(-0.85, 2.20, -0.45), // Back-top-left
            SCNVector3(0.85, 0, 0.05),      // Front-bottom-right
            SCNVector3(-0.85, 0, 0.05),     // Front-Bottom-left
            SCNVector3(-0.85, 0, -0.45),    // Back-Bottom-left
            SCNVector3(0.85, 0, -0.45)      // Back-Bottom-right
        ]
    
        let source = SCNGeometrySource(vertices: vertices)
        
        let indices: [UInt16] = [3, 2, 6, 7, 4, 2, 0, 3, 1, 6, 5, 4, 1, 0]
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
        
        let geometry = SCNGeometry(sources: [source], elements: [element])
        
        let node = SCNNode(geometry: geometry)

        geometry.firstMaterial?.diffuse.contents = UIColor(red:1.0,green:0.5,blue:0.1,alpha:0.7)
        
        let scnView = self.view as! SCNView
        
        scnView.scene?.rootNode.addChildNode(node)
    }
    
    func addLeftSidescreenGeometry() {
        let vertices: [SCNVector3] = [
            SCNVector3(-0.85, 2.20, 0.05),  // Front-top-right
            SCNVector3(-1.70, 2.20, 0.05),  // Front-top-left
            SCNVector3(-0.85, 2.20, -0.15), // Back-top-right
            SCNVector3(-1.70, 2.20, -0.15), // Back-top-left
            SCNVector3(-0.85, 0, 0.05),     // Front-bottom-right
            SCNVector3(-1.70, 0, 0.05),     // Front-Bottom-left
            SCNVector3(-1.70, 0, -0.15),    // Back-Bottom-left
            SCNVector3(-0.85, 0, -0.15)     // Back-Bottom-right
        ]
    
        let source = SCNGeometrySource(vertices: vertices)
        
        let indices: [UInt16] = [3, 2, 6, 7, 4, 2, 0, 3, 1, 6, 5, 4, 1, 0]
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
        
        let geometry = SCNGeometry(sources: [source], elements: [element])
        
        let node = SCNNode(geometry: geometry)

        geometry.firstMaterial?.diffuse.contents = UIColor(red:0.5,green:0.7,blue:0.5,alpha:0.7)
        
        let scnView = self.view as! SCNView
        
        scnView.scene?.rootNode.addChildNode(node)
    }
    
    func addRightSidescreenGeometry() {
        let vertices: [SCNVector3] = [
            SCNVector3(1.70, 2.20, 0.05),   // Front-top-right
            SCNVector3(0.85, 2.20, 0.05),   // Front-top-left
            SCNVector3(1.70, 2.20, -0.15),  // Back-top-right
            SCNVector3(0.85, 2.20, -0.15),  // Back-top-left
            SCNVector3(1.70, 0, 0.05),      // Front-bottom-right
            SCNVector3(0.85, 0, 0.05),      // Front-Bottom-left
            SCNVector3(0.85, 0, -0.15),     // Back-Bottom-left
            SCNVector3(1.70, 0, -0.15)      // Back-Bottom-right
        ]
    
        let source = SCNGeometrySource(vertices: vertices)
        
        let indices: [UInt16] = [3, 2, 6, 7, 4, 2, 0, 3, 1, 6, 5, 4, 1, 0]
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
        
        let geometry = SCNGeometry(sources: [source], elements: [element])
        
        let node = SCNNode(geometry: geometry)

        geometry.firstMaterial?.diffuse.contents = UIColor(red:0.5,green:0.7,blue:0.5,alpha:0.7)
        
        let scnView = self.view as! SCNView
        
        scnView.scene?.rootNode.addChildNode(node)
    }
    
    func ObjectCube() {
        let vertices: [SCNVector3] = [
            SCNVector3(0.45,    1.0,    0.0),   // Front-top-right
            SCNVector3(0.0,    1.0,    0.0),    // Front-top-left
            SCNVector3(0.45,    1.0,    -0.2),  // Back-top-right
            SCNVector3(0.0,    1.0,    -0.2),   // Back-top-left
            SCNVector3(0.45,    0.0,    0.0),   // Front-bottom-right
            SCNVector3(0.0,    0.0,    0.0),    // Front-Bottom-left
            SCNVector3(0.0,    0.0,    -0.2),   // Back-Bottom-left
            SCNVector3(0.45,    0.0,    -0.2),  // Back-Bottom-right
        ]
        
        let source = SCNGeometrySource(vertices: vertices)
        
        let indices: [UInt16] = [3, 2, 6, 7, 4, 2, 0, 3, 1, 6, 5, 4, 1, 0]
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
        
        let geometry = SCNGeometry(sources: [source], elements: [element])
        
        let node = SCNNode(geometry: geometry)

        geometry.firstMaterial?.diffuse.contents = UIColor(red:0,green:0,blue:0,alpha:1)
        
        let scnView = self.view as! SCNView
        
        scnView.scene?.rootNode.addChildNode(node)
    }
    
    func SensorCube() {
        let vertices: [SCNVector3] = [
            SCNVector3(0.1,    2.40,    0.0),   // Front-top-right
            SCNVector3(-0.1,    2.40,    0.0),  // Front-top-left
            SCNVector3(0.1,    2.40,    -0.1),  // Back-top-right
            SCNVector3(-0.1,    2.40,    -0.1), // Back-top-left
            SCNVector3(0.1,    2.30,    0.0),   // Front-bottom-right
            SCNVector3(-0.1,    2.30,    0.0),  // Front-Bottom-left
            SCNVector3(-0.1,    2.30,    -0.1), // Back-Bottom-left
            SCNVector3(0.1,    2.30,    -0.1),  // Back-Bottom-right
        ]
        
        let source = SCNGeometrySource(vertices: vertices)
        
        let indices: [UInt16] = [3, 2, 6, 7, 4, 2, 0, 3, 1, 6, 5, 4, 1, 0]
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
        
        let geometry = SCNGeometry(sources: [source], elements: [element])
        
        let node = SCNNode(geometry: geometry)

        geometry.firstMaterial?.diffuse.contents = UIColor(red:0,green:0,blue:0,alpha:1)
        
        let scnView = self.view as! SCNView
        
        scnView.scene?.rootNode.addChildNode(node)
    }
    
    func Grid() {
        var vertices = [SCNVector3]()
        var indices : [Int16]=[]
        
        for i in -10...10 {
                let vertice1 = SCNVector3(Double(i), 0.0, -10.0)
                vertices.append(vertice1)
                let vertice2 = SCNVector3(Double(i), 0.0, 10.0)
                vertices.append(vertice2);
                let vertice3 = SCNVector3(-10.0, 0.0, Double(i))
                vertices.append(vertice3);
                let vertice4 = SCNVector3(10.0, 0.0, Double(i))
                vertices.append(vertice4);
                
            }
        
        for i in 0...100{indices.append( Int16(i))}
        
        let source = SCNGeometrySource(vertices: vertices)
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        
        let geometry = SCNGeometry(sources: [source], elements: [element])
        
        let node = SCNNode(geometry: geometry)
        
        geometry.firstMaterial?.diffuse.contents = UIColor(red:0.3,green:0.7,blue:0.8,alpha:1)
        
        let scnView = self.view as! SCNView
        
        scnView.scene?.rootNode.addChildNode(node)
        
        //let rotateAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: .pi, z: 0, duration: 5))
        //node.runAction(rotateAction)
    }
    
    func Circle() {
        var vertices = [SCNVector3]()
        var indices : [Int16]=[]
        for i in 0...360 {
            let per = Float(i) / Float(360)
            let angle = per * (Float.pi * 2)
                           
            let vertice1 = SCNVector3(cos(angle), 0,sin(angle)+1.2)
            vertices.append(vertice1)
            let vertice2 = SCNVector3(0, 0, 0+0.2)
            vertices.append(vertice2)
        }
        
        for i in 0...720{indices.append( Int16(i))}
        
        let source = SCNGeometrySource(vertices: vertices)
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
        
        let geometry = SCNGeometry(sources: [source], elements: [element])
        
        let node = SCNNode(geometry: geometry)
        //node.position = SCNVector3(0, 0, 0.2)
        geometry.firstMaterial?.diffuse.contents = UIColor(red:0.0,green:0.3,blue:1.0,alpha:1)
        geometry.firstMaterial?.isDoubleSided = true    // both side will be visible like 3D shape
        let scnView = self.view as! SCNView
        
        scnView.scene?.rootNode.addChildNode(node)
    }

    func Cone() {
        var vertices = [SCNVector3]()
        var indices : [Int16]=[]
        for i in 0...360 {
            let per = Float(i) / Float(360)
            let angle = per * (Float.pi * 2)
                           
            let vertice1 = SCNVector3(cos(angle), 0,sin(angle)+1.2)
            vertices.append(vertice1)
            let vertice2 = SCNVector3(0, 2.20, 0)
            vertices.append(vertice2)
        }
        
        for i in 0...720{indices.append( Int16(i))}
        
        let source = SCNGeometrySource(vertices: vertices)
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
        
        let geometry = SCNGeometry(sources: [source], elements: [element])
        
        let node = SCNNode(geometry: geometry)

        geometry.firstMaterial?.diffuse.contents = UIColor(red:0.0,green:0.4,blue:1.0,alpha:0.4)
        //geometry.firstMaterial?.isDoubleSided = true
        let scnView = self.view as! SCNView
        
        scnView.scene?.rootNode.addChildNode(node)
    }
    
    func VirtualPushButton() {
        var vertices = [SCNVector3]()
        var indices : [Int16]=[]
        for i in 0...360 {
            let per = Float(i) / Float(360)
            let angle = per * (Float.pi * 2)
            let radius = Float(0.3)
            let vertice1 = SCNVector3(cos(angle)*radius,sin(angle)*radius, 0)
            vertices.append(vertice1)
            let vertice2 = SCNVector3(0, 0, 0)
            vertices.append(vertice2)
        }
        
        for i in 0...720{indices.append( Int16(i))}
        
        let source = SCNGeometrySource(vertices: vertices)
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
        
        let geometry = SCNGeometry(sources: [source], elements: [element])
        
        let node = SCNNode(geometry: geometry)
        node.position = SCNVector3(1, 1, 0)       //for placement of Circle
        geometry.firstMaterial?.diffuse.contents = UIColor(red:1.0,green:0.7,blue:0.0,alpha:1)
        geometry.firstMaterial?.isDoubleSided = true
        let scnView = self.view as! SCNView
        
        scnView.scene?.rootNode.addChildNode(node)
        
        
        //let rotateAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: .pi, z: 0, duration: 5))
        //node.runAction(rotateAction)
        
    }
    
}
