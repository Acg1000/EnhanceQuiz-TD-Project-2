//
//  GameManager.swift
//  EnhanceQuizStarter
//
//  Created by Andrew Graves on 5/2/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//
import GameKit

struct GameManager {
    var currentRound: Int
    var questions: [Question]
    var numberOfQuestions: Int

    // Returns a random question when called
    //create 4 random numbers that are not the same in a random order
    //store those numbers in an array of questions ready to use
    init() {
        self.currentRound = 0
        let quiz = Quiz()
        numberOfQuestions = quiz.questions.count
        

        // We want to make sure that we have give half of the total questions in order to maintain a good level of randomness
        if numberOfQuestions % 2 == 0 {
            numberOfQuestions = numberOfQuestions / 2
        } else {
            numberOfQuestions = (numberOfQuestions - 1) / 2
        }
        
        self.questions = []
        self.questions = generateQuestions(count: numberOfQuestions)
    }
    
    // increments the round counter by 1 each time its called
    mutating func incrementRound() {
        currentRound += 1
    }
    
    // Generates all the questions depending on the number of questions in the Quiz array
    func generateQuestions(count: Int) -> [Question] {
        let quiz = Quiz()
        var questionNumbers = [Int]()
        var randomNumber = Int()
        var selectedQuestions = [Question]()
        
        while count > 0 {
            randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: count)
            if !questionNumbers.contains(randomNumber) {
                questionNumbers.append(randomNumber)

            }
            
            for number in questionNumbers {
                selectedQuestions.append(quiz.questions[number])
            }
        }
        
        return selectedQuestions
    }
    
    mutating func resetGame() {
        currentRound = 0
        let quiz = Quiz()
        numberOfQuestions = quiz.questions.count
        
        
        // We want to make sure that we have give half of the total questions in order to maintain a good level of randomness
        if numberOfQuestions % 2 == 0 {
            numberOfQuestions = numberOfQuestions / 2
        } else {
            numberOfQuestions = (numberOfQuestions - 1) / 2
        }
        
        self.questions = []
        self.questions = generateQuestions(count: numberOfQuestions)
    }
    
    
//    func getRandomQuestion(questionCount: Int) -> Question {
//        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questionCount)
//        return questions[randomNumber]
//    }
    
    
    //function that gives one of the random questions and removes it from the ready to use questions array
    //
}
