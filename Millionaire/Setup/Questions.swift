//
//  Questions.swift
//  Millionaire
//
//  Created by Laurens on 19.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation

struct QuestionAnswers {
    
    let id: Int
    let answer: String
    
}


struct Question {
    
    let id: Int
    let question: String
    var answers: [QuestionAnswers]
    let correctAnswer: Int
    
}


let questions: [Question] = [
    
    Question(id: 0, question: "Wie viele Schüler/innen besuchen die HTBLA Kaindorf?", answers: [QuestionAnswers(id: 0, answer: "Ca. 50 Schüler/innen"), QuestionAnswers(id: 1, answer: "Ca. 100 Schüler/innen"), QuestionAnswers(id: 2, answer: "Ca. 500 Schüler/innen"), QuestionAnswers(id: 3, answer: "Ca. 1000 Schüler/innen")], correctAnswer: 3),
    Question(id: 1, question: "Wie viele Lehrer unterrichten an der HTBLA Kaindorf?", answers: [QuestionAnswers(id: 0, answer: "Ca. 20 Lehrer/innen"), QuestionAnswers(id: 1, answer: "Ca. 80 Lehrer/innen"), QuestionAnswers(id: 2, answer: "Ca. 100 Lehrer/innen"), QuestionAnswers(id: 3, answer: "Ca. 200 Lehrer/innen")], correctAnswer: 2),
    Question(id: 2, question: "Wie viele Abteilungen gibt es an der HTBLA Kaindorf?", answers: [QuestionAnswers(id: 0, answer: "2 Abteilungen"), QuestionAnswers(id: 1, answer: "3 Abteilungen"), QuestionAnswers(id: 2, answer: "4 Abteilungen"), QuestionAnswers(id: 3, answer: "5 Abteilungen")], correctAnswer: 2),
    Question(id: 3, question: "Wie viele Abteilungsvorstände gibt es an der HTBLA Kaindorf?", answers: [QuestionAnswers(id: 0, answer: "1 Abteilungsvorstand"), QuestionAnswers(id: 1, answer: "2 Abteilungsvorstände"), QuestionAnswers(id: 2, answer: "3 Abteilungsvorstände"), QuestionAnswers(id: 3, answer: "4 Abteilungsvorstände")], correctAnswer: 1),
    Question(id: 3, question: "Seit wie vielen Jahren gibt es unsere Schule?", answers: [QuestionAnswers(id: 0, answer: "10 Jahre"), QuestionAnswers(id: 1, answer: "20 Jahre"), QuestionAnswers(id: 2, answer: "25 Jahre"), QuestionAnswers(id: 3, answer: "30 Jahre")], correctAnswer: 2)

]
