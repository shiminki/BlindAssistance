//
//  ContentView.swift
//  Obj-Detection
//
//  Created by Adonis Serrano on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isTapped: Bool = false
    let textToSpeechManager = SpeechController()
    
    var body: some View {
            ZStack {
                // live video feed
                HostedViewController()
                    .ignoresSafeArea()
                
                // Button Overlay
                Button(action: {
                    if isTapped{
                        textToSpeechManager.speak(text: "How can we help you...")
                    } else {
                        textToSpeechManager.speak(text: "Tap to nod")
                    }
                    isTapped.toggle()
                }) {
                    Text(isTapped ? "Tap to N.O.D" : "How can we help you...")
                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
            }
    }
}

#Preview {
    ContentView()
}
