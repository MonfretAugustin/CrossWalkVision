//
//  SessionManager.swift
//  CrossWalkVision
//
//  Created by Augustin Monfret on 06/04/2022.
//

import ARKit
import Foundation
import RealityKit
import CoreVideo

class SessionManager: NSObject, ObservableObject, ARSessionDelegate {
    let arEngine: AREngine
    // MARK: Published var
    
    @Published var output: OutputFormat
    var outputQueue: OutputFormat
    var rationFrame:Int = 4
    var frameCount:Int = 1
    
    override init() {
        print("Creating AREngine...")
        arEngine = AREngine()
        print("...AREngine created!")
        output = OutputFormat()
        outputQueue = OutputFormat()
        
        super.init()
        print("Configuring engines...")
        arEngine.configureARView(self)

        print("...engines configured!")
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Image resolution (1920.0, 1440.0)
        
        if frameCount % rationFrame == 0 {
            outputQueue = output
            DispatchQueue.global().async {

                // resize pixel buffer
                let destPixelBuffer : CVPixelBuffer? = createPixelBuffer(width: 768, height: 576)

                guard let resizedPixelBuffer = destPixelBuffer else { return }

                resizePixelBuffer(from: frame.capturedImage, to: resizedPixelBuffer, width: 768, height: 576)

                do {
                    let prediction = try? analyzeImage(buffer: resizedPixelBuffer)
                    if prediction != nil {
                        self.outputQueue.addValue(newValue: prediction!)
                    }
                }
                catch {
                    print("Error during prediction")
                }
            }
            output = outputQueue
            frameCount = 1
        } else {
            frameCount += 1
        }
        
    }
}


