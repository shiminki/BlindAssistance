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

class SpeechController: NSObject, AVSpeechSynthesizerDelegate{
    // Create a speech synthesizer
    let SpeechSynthesizer = AVSpeechSynthesizer()
    
    func speak(text: String){
        // Create an utterance
        let utterance = AVSpeechUtterance(string: text)

        // Utterance Configuration
        utterance.rate = 0.5
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.2
        utterance.volume = 0.8
        
        // Tell the synthesizer to speak the utterance
        SpeechSynthesizer.delegate = self
        SpeechSynthesizer.speak(utterance)
    }
    
    func stopSpeaking() {
        SpeechSynthesizer.stopSpeaking(at: .immediate)
    }
}
