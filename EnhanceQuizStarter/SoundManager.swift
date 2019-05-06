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
    
    
    mutating func loadStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let url = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(url as CFURL, &gameSound)
        print("start sound loaded")
    }
    
    mutating func loadCorrectSound() {
        let path = Bundle.main.path(forResource: "CorrectSound", ofType: "wav")
        let url = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(url as CFURL, &correctSound)
        print("correct sound loaded")
    }
    
    mutating func loadIncorrectSound() {
        let path = Bundle.main.path(forResource: "IncorrectSound", ofType: "wav")
        let url = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(url as CFURL, &incorrectSound)
        print("incorrect sound loaded")
    }
    
    func playStartSound() {
        AudioServicesPlaySystemSound(gameSound)

    }
    
    func playCorrectSound() {
        AudioServicesPlaySystemSound(correctSound)

    }
    
    func playIncorrectSound() {
        AudioServicesPlaySystemSound(incorrectSound)

    }
}


