//
//  ResultViewController.swift
//  Quiz
//
//  Created by Nikita Petrenkov on 22/04/2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    /// Ответы от предыдущего экрана
    var answers: [Answer] = []

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Результат"
        navigationItem.hidesBackButton = true

        calculateAnimal()
    }

    /// Высчитываем тип животного на основе ответов
    private func calculateAnimal() {
        
        var dictionaryOfAnswers: [AnimalType: Int] = [:]
        
        let arrayOfAnimalTypes = answers.map { $0.animalType }
        
        for animal in arrayOfAnimalTypes {
            
            dictionaryOfAnswers[animal] = dictionaryOfAnswers[animal] ?? 0 + 1
        }
        
        let sortedDictionary = dictionaryOfAnswers.sorted(by: { (pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        
        guard let mostPopularTypeOfAnimals = sortedDictionary.first?.key else { return }
        
        // Выводим результаты
        titleLabel.text = "Ты - \(mostPopularTypeOfAnimals.rawValue)!"
        descriptionLabel.text = mostPopularTypeOfAnimals.description
    }
}
