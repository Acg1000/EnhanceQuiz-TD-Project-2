//
//  Question.swift
//  EnhanceQuizStarter
//
//  Created by Andrew Graves on 5/2/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//


// this is the structure for the questions
struct Question {
    let question: String
    let possibleAnswers: [String]
    let correctAnswer: Int
    
    //TODO ADD AN INTERNAL FUNCTION TO CHECK FOR CORRECT ANSWERS
    func isCorrect(input: String) -> [Bool: String] {
        if input == possibleAnswers[correctAnswer] {
            return [true: ""]
        } else {
            return [false: possibleAnswers[correctAnswer]]
        }
    }
    
    func getCorrectAnswer() -> String{
        return possibleAnswers[correctAnswer]
    }
}
