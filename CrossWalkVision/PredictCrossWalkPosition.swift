//
//  PredictCrossWalkPosition.swift
//  CrossWalkVision
//
//  Created by Augustin Monfret on 06/04/2022.
//

import Foundation
import CoreML
import UIKit


class OutputFormat: ObservableObject {
    @Published var x1: CGFloat
    @Published var y1: CGFloat
    @Published var x2: CGFloat
    @Published var y2: CGFloat
    
    init(output: MLMultiArray) {
        x1 = CGFloat(truncating: output[0])
        y1 = CGFloat(truncating: output[1])
        x2 = CGFloat(truncating: output[2])
        y2 = CGFloat(truncating: output[3])
    }
    
    init() {
        x1 = 0
        y1 = 0
        x2 = 0
        y2 = 0
    }
    
    func addValue(newValue: OutputFormat) {
        let factor = CGFloat(15)
        x1 = newValue.x1
        x2 = newValue.x2
        y1 = newValue.y1
        y2 = newValue.y2

    }
    
    func display() {
        print("Début: (\(x2*1920),\(y2*1440)); Fin: (\(x1*1920),\(y1*1440))")
    }
}

func analyzeImage(buffer: CVPixelBuffer) -> OutputFormat? {

    do {
        let config = MLModelConfiguration()
        let crosswalkVisionModel = try CrosswalkVisionModel(configuration: config)
        let input = CrosswalkVisionModelInput(input_1: buffer)
        
        let output = try crosswalkVisionModel.prediction(input: input)
        
        return OutputFormat(output: output._452)
    }
    catch {
        print("Error during prediction")
    }
    
    return nil
}
