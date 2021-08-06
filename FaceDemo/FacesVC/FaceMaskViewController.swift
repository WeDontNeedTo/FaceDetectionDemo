//
//  FaceMaskViewController.swift
//  FaceDemo
//
//  Created by Danil on 06.08.2021.
//

import UIKit
import ARKit

class FaceMaskViewController: UIViewController {
    
    let scene = ARSCNView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Face mask"
        setupARScene()
    }
}

// MARK: - setup ar scene
extension FaceMaskViewController {
    private func setupARScene() {
        view.addSubview(scene)
        scene.delegate = self
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        scene.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

// MARK: - ARSCNViewDelegate
extension FaceMaskViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = scene.device else {
            return nil
        }
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)
        node.geometry?.firstMaterial?.fillMode = .lines
        
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
              let faceGeometry = node.geometry as? ARSCNFaceGeometry else { return  }
        faceGeometry.update(from: faceAnchor.geometry)
    }
}

