//
//  ARViewController.swift
//  SberbankStepUp
//
//  Created by Svetlana Timofeeva on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

public final class ARViewController: UIViewController {

    var arView : ARSCNView!
    let configuration  = ARWorldTrackingConfiguration()
    var data : [AnalyticStruct]!
    
    let textScale = 0.007
    let tubeRadius = 1.0
    
    init(data : [AnalyticStruct]) {
		super.init(nibName: nil, bundle: nil)
        self.data = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        arView = ARSCNView()
        view.addSubview(arView)
        arView.frame = view.safeAreaLayoutGuide.layoutFrame
        arView.session.run(configuration)
        
        for (i, _) in data.enumerated() {
            createAndPlaceAnaliticStructNode(by: i)
        }
        
        let tube = SCNNode()
        tube.geometry = SCNTube(innerRadius: CGFloat(tubeRadius * 1.1), outerRadius: CGFloat(tubeRadius * 1.1), height: 1)
        tube.position = SCNVector3(0, 0, 0)
        tube.geometry?.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.75)
        arView.scene.rootNode.addChildNode(tube)
        
        let logo = SCNNode()
        logo.geometry = SCNTube(innerRadius: 0, outerRadius: CGFloat(0.1), height: 0.05)
        logo.position = SCNVector3(0, 1, 0)
        logo.rotation = SCNVector4(0, 0, -1, Double.pi / 2.0)
        logo.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "sberlogo")
        arView.scene.rootNode.addChildNode(logo)
        logo.runAction(SCNAction.rotate(toAxisAngle: SCNVector4(1, 0, 0, 2 * Double.pi * 1000), duration: 3000))
        arView.autoenablesDefaultLighting = true
    }
    
    func createAndPlaceAnaliticStructNode(by index: Int) {
        let analiticStruct = data[index]
        addText("\(String(format: "%.0f", analiticStruct.money))RUB", toIndex: index, toHeight: 0.1, ofSize: 1)
        if (abs(analiticStruct.difference) < 0.01) {
            addText("(\(String(format: "%.2f", analiticStruct.difference))%)", toIndex: index, toHeight: 0.04, ofSize: 0.7)
        } else {
            addText("(\(analiticStruct.difference > 0.0 ? "+" : "-")\(String(format: "%.2f", analiticStruct.difference))%)", toIndex: index, toHeight: 0.04, ofSize: 0.7)
        }
        addText("\(analiticStruct.month), \(analiticStruct.year)", toIndex: index, toHeight: -0.05, ofSize: 0.7)
    }
    
    func addText(_ text: String, toIndex index: Int, toHeight height: Double, ofSize size : Double) {
        let geometry = SCNText(string: text, extrusionDepth: 0.1  )
        geometry.flatness = 0.01
        geometry.chamferRadius = 0.3
        geometry.font = UIFont(name: "Menlo", size: CGFloat(size))
        let node = getNodeOfTextObjWith(geometry, index: index, height: height, analiticConslusion: data[index].conclusion)
        node.geometry = geometry
    }
    
    func getNodeOfTextObjWith(_ textObj: SCNText, index: Int, height: Double = 0, analiticConslusion : AnaliticConclusion = .rise) -> SCNNode {
        let node = SCNNode()
        node.geometry = textObj
        node.scale = SCNVector3(0.07, 0.07, 0.07)
        let (min, max) = node.boundingBox
        let dx = min.x + 0.5 * (max.x - min.x)
        let dy = min.y + 0.5 * (max.y - min.y)
        let dz = min.z + 0.5 * (max.z - min.z)
        let angle = Double(index) * 2.0 * Double.pi / Double(data.count)
        node.pivot = SCNMatrix4MakeTranslation(dx, dy, dz)
        node.position = SCNVector3(tubeRadius * sin(angle), height, tubeRadius * (-cos(angle)))
        node.rotation = SCNVector4(0, 1, 0, -angle)
        switch analiticConslusion {
        case .drop:
            node.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        case .rise:
            node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        case .stability:
            node.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        }
        arView.scene.rootNode.addChildNode(node)
        return node
    }
}

