//
//  SpeechService.swift
//  NewsSwiftUI
//
//  Created by Ildar Garifullin on 17.03.2026.
//

import AVFoundation

final class SpeechService {

    private let synthesizer = AVSpeechSynthesizer()

    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0

        synthesizer.speak(utterance)
    }
}
