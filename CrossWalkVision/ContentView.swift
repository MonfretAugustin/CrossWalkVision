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
//        Button("test") {
//            sessionManager.output.display()
//        }
        ARViewContainer().environmentObject(sessionManager)
            .frame(width: 384, height: 288)
            .overlay(GeometryReader { gp in
                Text(String(Float(gp.size.height)))
                    .position(x: gp.size.width*sessionManager.output.x1, y: gp.size.height*(sessionManager.output.y1))
                Text(String(Float(gp.size.width)))
                    .position(x: gp.size.width*sessionManager.output.x2, y: gp.size.height*(sessionManager.output.y2))
            }
        )
//        Image(uiImage: UIImage(named: "crosswalk")!.resize(size: CGSize(width: 768, height: 576))!)
//            .resizable()
//            .scaledToFit()
//            .overlay(GeometryReader { gp in
//                Text("Hello")
//                    .position(x: gp.size.width*sessionManager.output.x1, y: gp.size.height*sessionManager.output.y1)
//                Text("Hello2")
//                    .position(x: gp.size.width*sessionManager.output.x2, y: gp.size.height*sessionManager.output.y2)
//            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ImageOverlay: View {
    var body: some View {
        Text("BONJOUR")
            .padding()
    }
}
