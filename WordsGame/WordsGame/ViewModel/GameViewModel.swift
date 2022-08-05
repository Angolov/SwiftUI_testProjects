//
//  GameViewModel.swift
//  WordsGame
//
//  Created by Антон Головатый on 05.08.2022.
//

import Foundation

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
    
    func validatePlayerWord(_ word: String) -> Bool {
        let word = word.lowercased()
        guard word != self.originalWord else {
            print("Error! It is the original word.")
            return false
        }
        
        guard !(words.contains(word)) else {
            print("Error! This word was already used.")
            return false
        }
        
        guard word.count > 1 else {
            print("Error! Your word is to short.")
            return false
        }
        
        return true
    }
    
    func wordToChars(word: String) -> [Character] {
        
        var chars = [Character]()
        
        for char in word.lowercased() {
            chars.append(char)
        }
        
        return chars
    }
    
    func check(word: String) -> Int {
        
        guard self.validatePlayerWord(word) else { return 0 }
        
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
                return 0
            }
        }
        
        guard result == word.lowercased() else {
            print("Error! Unknown error")
            return 0
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
