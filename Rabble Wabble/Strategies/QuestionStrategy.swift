//
//  QuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Hoang Trong Kien on 3/29/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

public protocol QuestionStrategy: class {
    var title: String { get }
    var correctCount: Int { get }
    var incorrectCount: Int { get }
    func advanceToNextQuestion() -> Bool
    func currentQuestion() -> Question
    func markQuestionCorrect(_ question: Question)
    func markQuestionIncorrect(_ question: Question)
    func questionIndexTitle() -> String
}
