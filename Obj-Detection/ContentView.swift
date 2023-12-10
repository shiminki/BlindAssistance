//
//  ContentView.swift
//  Obj-Detection
//
//  Created by Adonis Serrano on 11/11/23.
//

import SwiftUI
import Speech

struct ContentView: View {
    // Class instances
    @State private var isSpeechRecognitionActive = false
    @State private var isSpeechRecieved = false
    let SpeechManager = SpeechController()
    
    // Important Variables
    @State private var spokenText = ""
    @State private var displayedText = ""
    @State private var listeningMessage = ""
    
    var body: some View {
        VStack(alignment:.center) {
            if isSpeechRecognitionActive && !isSpeechRecieved{
                // Display for speec recognition
                Text("What do you need to find?")
                    .font(.title)
                    .padding()
                
                // for speech recognition startup
                    .onAppear{
                        // add logic for starting speech recognition
                        displayedText = "What do you need to find?"
                        SpeechManager.speak(text: displayedText)
                        startSpeechRecognition()
                        
                    }
                
                Text(listeningMessage)
                    .font(.title)
                    .padding()
                
            } else if !isSpeechRecognitionActive && isSpeechRecieved{
                Text(spokenText)
                    .font(.title)
                    .padding()
                    .onTapGesture{
                        isSpeechRecieved = false
                        isSpeechRecognitionActive = false
                    }
                
            } else {
                ZStack{
                    // live video feed
                    HostedViewController()
                        .ignoresSafeArea()
                    
                    // Text for Display
                    Text("Tap to N.O.D")
                        .font(.title)
                        .padding()
                    // for text-to-speed
                        .onAppear(){
                            displayedText = "Tap to nod"
                            SpeechManager.speak(text: displayedText)
                        }
                        .onTapGesture {
                            SpeechManager.isSpeechRecognitionActive = true
                            isSpeechRecognitionActive = true
                        }
                }
                
            }
            
        }
    }
    
    func startSpeechRecognition() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == .authorized {
                let speechRecognizer = SFSpeechRecognizer()
                let request = SFSpeechAudioBufferRecognitionRequest()
                
                let audioEngine = AVAudioEngine()
                // Configure the audio session for the app.
                let audioSession = AVAudioSession.sharedInstance()
                
                do {
                    try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
                    try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                } catch {
                    // implamenet error handling
                }
                
                let inputNode = audioEngine.inputNode
                
                // Configure and start the audio engine
                let recordingFormat = inputNode.outputFormat(forBus: 0)
                inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                    request.append(buffer)
                }
                
                audioEngine.prepare()
                do {
                    try audioEngine.start()
                    
                    // Display a message indicating that the app is listening
                    DispatchQueue.main.async {
                        // Update UI if necessary
                        self.listeningMessage = "Listening..."
                    }
                    
                    // Declare recognitionTask outside the installTap closure
                    var recognitionTask: SFSpeechRecognitionTask?
                    
                    // Start speech recognition task
                    recognitionTask = speechRecognizer?.recognitionTask(with: request) { result, _ in
                        if let result = result {
                            let transcribedSpeech = result.bestTranscription.formattedString
                            self.spokenText = transcribedSpeech
                            self.isSpeechRecieved = true
                            self.isSpeechRecognitionActive = false // End speech recognition
                            audioEngine.stop()
                            recognitionTask?.cancel()
                            
                            // Do something with the transcribed text (e.g., initiate image capture/upload)
                            DispatchQueue.main.async {
                                SpeechManager.speak(text: spokenText) // Optionally, speak the transcribed text
                            }
                        }
                    }
                    
                } catch {
                    // Handle audio engine start error
                }
            }
        }
    }
}

// for previewing content
#Preview {
    ContentView()
}
