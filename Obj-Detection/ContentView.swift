//
//  ContentView.swift
//  Obj-Detection
//
//  Created by Adonis Serrano on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isTapped: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // live video feed
                HostedViewController()
                    .ignoresSafeArea()
                
                // screen text toggles
                if !isTapped {
                    Color.black.opacity(0.1) // Black overlay with 0.9 opacity
                                    .edgesIgnoringSafeArea(.all)
                    Text("Tap the Screen to N.O.D")
                        .font(.custom(
                            "Copperplate",
                            fixedSize: 36)
                            .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                }
                
                if isTapped {
                    Color.black.opacity(0.8) // Black overlay with 0.9 opacity
                                    .edgesIgnoringSafeArea(.all)
                    
                    Text("Start Talking...")
                        .font(.custom(
                            "Copperplate",
                            fixedSize: 36)
                            .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                    
                }
                
            }.onTapGesture{
                    // text
                    self.isTapped.toggle()
                }
    
        }
        
    }
}

#Preview {
    ContentView()
}
