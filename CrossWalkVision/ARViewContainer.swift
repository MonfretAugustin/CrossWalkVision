//
//  ARViewContainer.swift
//  CrossWalkVision
//
//  Created by Augustin Monfret on 06/04/2022.
//

import RealityKit
import SwiftUI

struct ARViewContainer: UIViewRepresentable {

    @EnvironmentObject var manager: SessionManager

    func makeUIView(context: Context) -> ARView {

        let arView = manager.arEngine.arView
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

}
