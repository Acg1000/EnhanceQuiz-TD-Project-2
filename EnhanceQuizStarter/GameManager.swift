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
    var score: Int

    init() {
        self.currentRound = 0
        self.score = 0
        let quiz = Quiz()
        numberOfQuestions = quiz.questions.count
        

        // We want to make sure that we have give half of the total questions in order to maintain a good level of randomness
        if numberOfQuestions % 2 == 0 {
            numberOfQuestions = numberOfQuestions / 2
        } else {
            numberOfQuestions = (numberOfQuestions - 1) / 2
        }
        
        self.questions = []
        self.questions = generateQuestions(count: numberOfQuestions, upperBound: quiz.questions.count)
    }
    
    // increments the round counter by 1 each time its called
    mutating func incrementRound() {
        currentRound += 1
    }
    
    // Generates all the questions depending on the number of questions in the Quiz array
    func generateQuestions(count: Int, upperBound: Int) -> [Question] {
        let quiz = Quiz()
        var questionNumbers = [Int]()
        var randomNumber = Int()
        var selectedQuestions = [Question]()
        var counter = count
        
        // Takes the number of questions that need to be generated and creates multiple random questions from that
        while counter > 0 {
            randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: upperBound)
            
            // If the random number is not in the array then add it.
            if !questionNumbers.contains(randomNumber) {
                questionNumbers.append(randomNumber)
                counter -= 1
            }
        }
        // Print for logging purposes
        print(questionNumbers)

        // For every random number, grab the corresponding question from the list
        for number in questionNumbers {
            selectedQuestions.append(quiz.questions[number])
        }
        
        // Return the random selected questions
        return selectedQuestions
    }
    
    // When called increse the score by one
    mutating func isCorrect() {
        score += 1
    }
    
    // When called, reset the game
    mutating func resetGame() {
        currentRound = 0
        let quiz = Quiz()
        numberOfQuestions = quiz.questions.count
        score = 0

        // We want to make sure that we have give half of the total questions in order to maintain a good level of randomness
        if numberOfQuestions % 2 == 0 {
            numberOfQuestions = numberOfQuestions / 2
        } else {
            numberOfQuestions = (numberOfQuestions - 1) / 2
        }
        
        self.questions = []
        self.questions = generateQuestions(count: numberOfQuestions, upperBound: quiz.questions.count)
    }
}
