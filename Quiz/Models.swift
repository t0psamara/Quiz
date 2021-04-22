//
//  Models.swift
//  Quiz
//
//  Created by Nikita Petrenkov on 22/04/2021.
//

import Foundation

/// Модель вопроса
struct Question {
    /// Сам вопрос
    let text: String
    /// Тип ответов
    let type: AnswerType
    /// Ответы
    let answers: [Answer]
}

/// Тип ответов
enum AnswerType {
    /// Единственный вариант ответа
    case single
    /// Несколько вариантов ответа
    case multiple
    /// Вариант ответа в виде интервала
    case range
}

/// Модель ответа
struct Answer {
    /// Непосредственно текст ответа
    let text: String
    /// Тип животинки
    let animalType: AnimalType
}

/// Тип животинки
enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var description: String {
        switch self {
        case .dog:
            return "Вы общительны, вам нравится находиться в компании людей, вы обожаете делать что-то совместно с другими."
        case .cat:
            return "Вы самодостаточны. Вам нравится самостоятельная жизнь"
        case .rabbit:
            return "Вам нравится кушать морковку. И прыгать"
        case .turtle:
            return "Вам нравится долго идти к цели. "
        }
    }
}
