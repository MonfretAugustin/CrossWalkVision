//
//  AREngine.swift
//  CrossWalkVision
//
//  Created by Augustin Monfret on 06/04/2022.
//

import AddressBookUI
import ARKit
import Foundation
import RealityKit

class AREngine {
    let arView = ARView(frame: .zero)
    var sessionManager: SessionManager!
    
    
    var defaultConfiguration: ARWorldTrackingConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.sceneReconstruction = .meshWithClassification
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        
        return configuration
    }
    
    init() {
        
    }
    
    func configureARView(_ initSessionManager: SessionManager) {
        sessionManager = initSessionManager
        
        arView.session.delegate = sessionManager
        arView.environment.sceneUnderstanding.options = []
        
//        // Turn on occlusion from the scene reconstruction's mesh.
//        arView.environment.sceneUnderstanding.options.insert(.occlusion)
//
//        // Turn on physics for the scene reconstruction's mesh.
//        arView.environment.sceneUnderstanding.options.insert(.physics)
//
//        // Display a debug visualization of the mesh.
//        arView.debugOptions.insert(.showSceneUnderstanding)

        // For performance, disable render options that are not required for this app.
        arView.renderOptions = [.disablePersonOcclusion, .disableDepthOfField, .disableMotionBlur]
        
        // Manually configure what kind of AR session to run since
        // ARView on its own does not turn on mesh classification.
        arView.automaticallyConfigureSession = false
        let configuration = defaultConfiguration
        arView.session.run(configuration)
    }
    

}
