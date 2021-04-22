//
//  QuestionViewController.swift
//  Quiz
//
//  Created by Nikita Petrenkov on 22/04/2021.
//

import UIKit

/// Контроллер вопросов
class QuestionViewController: UIViewController {
    
    /// Данные по вопросам и ответам (типа от сервера получили)
    private let questions: [Question] = [
        Question(
            text: "Какая еда вам нравится?",
            type: .single,
            answers: [
                Answer(text: "Стейк", animalType: .dog),
                Answer(text: "Рыба", animalType: .cat),
                Answer(text: "Морковка", animalType: .rabbit),
                Answer(text: "Кукуруза", animalType: .turtle)
            ]
        ),
        Question(
            text: "Что вам нравится делать?",
            type: .multiple,
            answers: [
                Answer(text: "Есть", animalType: .dog),
                Answer(text: "Спать", animalType: .cat),
                Answer(text: "Прыгать", animalType: .rabbit),
                Answer(text: "Плавать", animalType: .turtle)
            ]
        ),
        Question(
            text: "Насколько вам нравятся поездки?",
            type: .range,
            answers: [
                Answer(text: "Ненавижу", animalType: .cat),
                Answer(text: "Отношусь к этому с тревогой", animalType: .rabbit),
                Answer(text: "Мне индиффирентно", animalType: .turtle),
                Answer(text: "Обожаю", animalType: .dog)
            ]
        )
    ]
    
    /// Текущий индекс вопроса
    private var questionIndex = 0
    
    /// Выбранные ответы
    private var chosenAnswers: [Answer] = []
    
    /// Сам текст вопроса
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    // MARK: - Первый тип вопроса
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    // MARK: - Второй тип вопроса
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    // MARK: - Третий тип вопроса
    
    @IBOutlet weak var rangeView: UIView!
    @IBOutlet weak var rangeSlider: UISlider!
    @IBOutlet weak var worstRangeLabel: UILabel!
    @IBOutlet weak var bestRangeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    

    /// Конфигурируем данные на экране
    private func updateUI() {
        // Сначала скрываем все виды вопросов
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangeView.isHidden = true
        
        // Текущий вопрос
        let currentQuestion = questions[questionIndex]
        // Вычисдяем прогресс
        let progress: Float = Float(questionIndex / questions.count)
        
        // Задаём текст вопроса
        questionLabel.text = currentQuestion.text
        
        progressView.setProgress(progress, animated: true)
        
        title = "Вопрос № \(questionIndex + 1)"
        
        switch currentQuestion.type {
        case .single:
            configureSingleQuestion(with: currentQuestion.answers)
            
        case .multiple:
            configureMultipleQuestion(with: currentQuestion.answers)
            
        case .range:
            configureRangeQuestion(with: currentQuestion.answers)
            
        }
    }
    
    /// Конфигурируем UI для первого вопроса
    private func configureSingleQuestion(with answers: [Answer]) {
        singleStackView.isHidden = false
        
        for index in 0..<singleButtons.count {
            singleButtons[index].setTitle(answers[index].text, for: .normal)
        }
    }
    
    /// Конфигурируем UI для второго вопроса
    private func configureMultipleQuestion(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for index in 0..<multipleLabels.count {
            multipleLabels[index].text = answers[index].text
            multipleSwitches[index].isOn = false
        }
    }
    
    /// Конфигурируем UI для третьего вопроса
    private func configureRangeQuestion(with answers: [Answer]) {
        rangeView.isHidden = false
        rangeSlider.setValue(0.5, animated: false)
        worstRangeLabel.text = answers.last?.text
        bestRangeLabel.text = answers.first?.text
    }
    
    /// Обрабатываем нажатия на кнопки из первого вопроса
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        
        let answers = questions[questionIndex].answers
        
        for index in 0..<singleButtons.count where singleButtons[index] == sender {
            chosenAnswers.append(answers[index])
        }
        
        goToNextQuestion()
        
    }
    
    /// Обрабатываем нажатие на кнопку второго вопроса
    @IBAction func multipleButtonPressed(_ sender: Any) {
        
        let answers = questions[questionIndex].answers
        
        for index in 0..<multipleSwitches.count where multipleSwitches[index].isOn {
            chosenAnswers.append(answers[index])
        }
        
        goToNextQuestion()
    }
    
    /// Обрабатываем нажатие на кнопку третьего вопроса
    @IBAction func rangeButtonPressed() {
        
        let answers = questions[questionIndex].answers
        
        let index = Int(round(rangeSlider.value * Float(answers.count - 1)))
        
        chosenAnswers.append(answers[index])
        
        
        goToNextQuestion()
    }
    
    /// Переходим на следующий вопрос или на следующий экран
    private func goToNextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            // Иначе, если прошли все вопросы, то отображаем экран с результатами
            performSegue(withIdentifier: "ResultVC", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ResultVC" else { return }
        
        let resultViewController = segue.destination as! ResultViewController
        
        resultViewController.answers = chosenAnswers
    }
}
