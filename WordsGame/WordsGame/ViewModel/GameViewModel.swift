//
//  GameViewModel.swift
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

class GameViewModel: ObservableObject {
    
    @Published var firstPlayer: Player
    @Published var secondPlayer: Player
    @Published var words = [String]()
    let originalWord: String
    var isFirstPlayerMove = true
    
    init(firstPlayer: Player, secondPlayer: Player, originalWord: String) {
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondPlayer
        self.originalWord = originalWord.lowercased()
    }
    
    func validatePlayerWord(_ word: String) throws {
        let word = word.lowercased()
        guard word != self.originalWord else {
            print("Error! It is the original word.")
            throw WordError.wordIsTheSame
        }
        
        guard !(words.contains(word)) else {
            print("Error! This word was already used.")
            throw WordError.wordWasAlreadyUsed
        }
        
        guard word.count > 1 else {
            print("Error! Your word is to short.")
            throw WordError.wordIsTooShort
        }
    }
    
    func wordToChars(word: String) -> [Character] {
        
        var chars = [Character]()
        
        for char in word.lowercased() {
            chars.append(char)
        }
        
        return chars
    }
    
    func check(word: String) throws -> Int {
        
        do {
            try self.validatePlayerWord(word)
        }
        catch {
            throw error
        }
        
        var originalWordArray = wordToChars(word: self.originalWord)
        let playerWordArray = wordToChars(word: word)
        var result = ""
        
        for char in playerWordArray {
            if originalWordArray.contains(char) {
                result.append(char)
                
                var i = 0
                
                while originalWordArray[i] != char {
                    i += 1
                }
                
                originalWordArray.remove(at: i)
                
            } else {
                print("Error! Your word cannot be created.")
                throw WordError.cannotCreateWord
            }
        }
        
        guard result == word.lowercased() else {
            print("Error! Unknown error")
            throw WordError.undefinedError
        }
        
        words.append(result)
        
        if isFirstPlayerMove {
            firstPlayer.add(score: result.count)
        } else {
            secondPlayer.add(score: result.count)
        }
        
        isFirstPlayerMove.toggle()
        
        return result.count
    }
}
