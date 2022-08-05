//
//  WordError.swift
//  WordsGame
//
//  Created by Антон Головатый on 05.08.2022.
//

import Foundation

enum WordError: Error {
    
    case wordIsTheSame
    case wordIsTooShort
    case wordWasAlreadyUsed
    case cannotCreateWord
    case undefinedError
    
    var description: String {
        switch self {
        case .wordIsTheSame:
            return "Это изначальное слово"
        case .wordIsTooShort:
            return "Ваше слово слишком короткое"
        case .wordWasAlreadyUsed:
            return "Это слово уже было использовано"
        case .cannotCreateWord:
            return "Невозможно составить слово"
        case .undefinedError:
            return "Неизвестная ошибка"
        }
    }
}
