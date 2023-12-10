//
//  SpeechController.swift
//  Obj-Detection
//
//  Created by Adonis Serrano on 12/5/23.
//

/*
 To use: in content view, instantiate class:
    let textToSpeechManager = SpeechController()
 Use class functions to text to speech, will input ways to change audio and other values later.
 */

import Foundation
import AVFAudio
import Speech
import SwiftUI

class SpeechController: NSObject, AVSpeechSynthesizerDelegate{
    // Create a speech synthesizer
    let SpeechSynthesizer = AVSpeechSynthesizer()
    var isSpeechRecognitionActive = false
    var inputText = ""
    var outputText = ""
    
    // function to speak text
    func speak(text: String){
        // Create an utterance
        let utterance = AVSpeechUtterance(string: text)

        // Utterance Configuration
        utterance.rate = 0.5
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.5
        utterance.volume = 0.8
        
        // Tell the synthesizer to speak the utterance
        SpeechSynthesizer.delegate = self
        SpeechSynthesizer.speak(utterance)
    }
    
    // function to stop speaking text
    func stopSpeaking() {
        SpeechSynthesizer.stopSpeaking(at: .immediate)
    }
}
