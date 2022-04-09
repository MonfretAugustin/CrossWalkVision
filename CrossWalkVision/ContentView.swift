//
//  ContentView.swift
//  CrossWalkVision
//
//  Created by Augustin Monfret on 06/04/2022.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @StateObject var sessionManager = SessionManager()
    
    var body: some View {
        Spacer()
        Text("CrossWalkVision")
            .font(.system(.title, design: .rounded))
        Spacer()
        ARViewContainer().environmentObject(sessionManager)
            .scaledToFit()
            .overlay(GeometryReader { gp in
                PositionView(positionType: .exit)
                    .position(x: gp.size.width*sessionManager.output.x1, y: gp.size.height*(sessionManager.output.y1))
                PositionView(positionType: .entry)
                    .position(x: gp.size.width*sessionManager.output.x2, y: gp.size.height*(sessionManager.output.y2))
            }
        )
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
