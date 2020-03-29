//
//  ViewController.swift
//  Rabble Wabble
//
//  Created by Hoang Trong Kien on 3/28/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

// MARK: - QuestionViewControllerDelegate
public protocol QuestionViewControllerDelegate: class {
    func questionViewController(_ viewController: QuestionViewController,
                                didCancel questionGroup: QuestionStrategy)
    func questionViewController(_ viewController: QuestionViewController,
                                didComplete questionStrategy: QuestionStrategy)
}

public class QuestionViewController: UIViewController {
    
    // MARK: - Instance Properties
    public var delegate: QuestionViewControllerDelegate?
    public var questionStrategy: QuestionStrategy! {
        didSet {
            navigationItem.title = questionStrategy.title
        }
    }
    public var questionIndex = 0
    public var correctCount = 0
    public var incorrectCount = 0
    public var questionView: QuestionView! {
        guard isViewLoaded else {
            return nil
        }
        return (view as! QuestionView)
    }
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "",
                                   style: .plain,
                                   target: nil,
                                   action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()
    }
    
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        let barButtonItem = UIBarButtonItem(image: image,
                                            landscapeImagePhone: nil,
                                            style: .plain,
                                            target: self,
                                            action: action)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(self, didCancel: questionStrategy)
    }
    
    private func showQuestion() {
        let question = questionStrategy.currentQuestion()
        
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        questionView.answerLabel.text = question.answer
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        
        questionIndexItem.title = questionStrategy.questionIndexTitle()
    }
    
    // MARK: - Actions
    @IBAction func toggleAnswerLabels(_ sender: Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }
    
    @IBAction func handleIncorrect(_ sender: UIButton) {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionIncorrect(question)
        questionView.incorrectCountLabel.text =
            String(questionStrategy.incorrectCount)
        showNextQuestion()
    }
    @IBAction func handleCorrect(_ sender: UIButton) {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionCorrect(question)
        questionView.correctCountLabel.text =
            String(questionStrategy.correctCount)
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionStrategy.advanceToNextQuestion() else {
            delegate?.questionViewController(self, didComplete: questionStrategy)
            return
        }
        showQuestion()
    }
}

