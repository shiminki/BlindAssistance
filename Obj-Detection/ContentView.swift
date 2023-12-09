//
//  ContentView.swift
//  Obj-Detection
//
//  Created by Adonis Serrano on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    // State variables for application
    @State private var isSpeechRecognitionActive = false;
    
    // Class instances
    let textToSpeechManager = SpeechController()
    
    // Important Variables
    @State private var spokenText = ""
    
    var body: some View {
        VStack(alignment:.center) {
                if isSpeechRecognitionActive{
                    // Display for speec recognition
                    Text("How can I help you today...")
                        .padding()
                        // for speech recognition startup
                        .onAppear{
                            spokenText = "How can I help you today"
                            textToSpeechManager.speak(text: spokenText)
                            
                            // add logic for starting speech recognition
                            
                        }
                } else {
                    ZStack{
                        // live video feed
                        HostedViewController()
                            .ignoresSafeArea()
                        
                        // Text for Display
                        Text("Tap to N.O.D")
                            .padding()
                            // for text-to-speed
                            .onAppear(){
                                spokenText = "Tap to nod"
                                textToSpeechManager.speak(text: spokenText)
                            }
                            .onTapGesture {
                                self.isSpeechRecognitionActive = true
                            }
                    }
                    
                }
                
            }
    }
}

// for previewing content
#Preview {
    ContentView()
}
