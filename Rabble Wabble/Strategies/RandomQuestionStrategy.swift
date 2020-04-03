//
//  RandomQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Hoang Trong Kien on 3/29/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit
import GameplayKit.GKRandomSource

public class RandomQuestionStrategy: BaseQuestionStrategy {
    
    public convenience init(
        questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let randomSource = GKRandomSource.sharedRandom()
        let questions = randomSource.arrayByShufflingObjects(
            in: questionGroup.questions) as! [Question]
        self.init(questionGroupCaretaker: questionGroupCaretaker,
                  questions: questions)
    }
}
