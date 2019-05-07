//
//  SoundManager.swift
//  EnhanceQuizStarter
//
//  Created by Andrew Graves on 5/6/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

struct SoundManager {
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 0
    var incorrectSound: SystemSoundID = 0
    
    // Load the start sounds
    mutating func loadStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let url = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(url as CFURL, &gameSound)
        print("start sound loaded")
    }
    
    // Load the correct sound
    mutating func loadCorrectSound() {
        if let url = Bundle.main.url(forResource: "CorrectSound", withExtension: "wav") {
            AudioServicesCreateSystemSoundID(url as CFURL, &correctSound)
        } else {
            print("correct sound not found")
        }
        print("correct sound loaded")
    }
    
    // Load the incorrect sound
    mutating func loadIncorrectSound() {
        if let url = Bundle.main.url(forResource: "IncorrectSound", withExtension: "wav") {
            AudioServicesCreateSystemSoundID(url as CFURL, &incorrectSound)
        } else {
            print("incorrect sound not found")
        }
        print("incorrect sound loaded")
    }
    
    // play start sound
    func playStartSound() {
        AudioServicesPlaySystemSound(gameSound)
        print("start sound played")

    }
    
    // play correct sound
    func playCorrectSound() {
        AudioServicesPlaySystemSound(correctSound)
        print("correct sound played")

    }
    
    // play incorrect sound
    func playIncorrectSound() {
        AudioServicesPlaySystemSound(incorrectSound)
        print("incorrect sound played")
        
    }
}


