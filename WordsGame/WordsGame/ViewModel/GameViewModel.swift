//
//  GameViewModel.swift
//  WordsGame
//
//  Created by Антон Головатый on 05.08.2022.
//

import Foundation

// MARK: - GameViewModel class

class GameViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var firstPlayer: Player
    @Published private(set) var secondPlayer: Player
    @Published private(set) var words = [String]()
    private(set) var isFirstPlayerTurn = true
    
    let originalWord: String
    
    // MARK: - Initializer
    
    init(firstPlayer: Player, secondPlayer: Player, originalWord: String) {
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondPlayer
        self.originalWord = originalWord.lowercased()
    }
    
    // MARK: - Public methods
    
    func finalizeTurnWith(word: String) throws {
        
        let playerWord = word.lowercased()
        var playerScore = 0
        
        do {
            try validatePlayerWord(playerWord)
            try playerScore = countScoreFor(word: playerWord)
            words.append(playerWord)
            addPlayerScore(score: playerScore)
            switchTurn()
        }
        catch {
            throw error
        }
    }
}

// MARK: - Private methods

private extension GameViewModel {
    
    private func validatePlayerWord(_ word: String) throws {
        if isSameWithOriginal(word) {
            throw WordError.wordIsTheSame
        }
        
        if isAlreadyUsed(word) {
            throw WordError.wordWasAlreadyUsed
        }
        
        if isTooShort(word) {
            throw WordError.wordIsTooShort
        }
    }
    
    private func isSameWithOriginal(_ word: String) -> Bool {
        return word == originalWord
    }
    
    private func isAlreadyUsed(_ word: String) -> Bool {
        return words.contains(word)
    }
    
    private func isTooShort(_ word: String) -> Bool {
        return word.count <= 1
    }
    
    private func countScoreFor(word: String) throws -> Int {
        var originalWordArray = wordToChars(word: originalWord)
        let playerWordArray = wordToChars(word: word)
        var score = 0
        
        for char in playerWordArray {
            
            if originalWordArray.contains(char),
               let charIndex = originalWordArray.firstIndex(of: char) {
                
                originalWordArray.remove(at: charIndex)
                score += 1
            
            } else {
                throw WordError.cannotCreateWord
            }
        }
        
        guard score != word.count else {
            throw WordError.undefinedError
        }
        
        return score
    }
    
    private func wordToChars(word: String) -> [Character] {
        var chars = [Character]()
        
        for char in word {
            chars.append(char)
        }
        
        return chars
    }
    
    private func addPlayerScore(score: Int) {
        if isFirstPlayerTurn {
            firstPlayer.add(score: score)
        } else {
            secondPlayer.add(score: score)
        }
    }
    
    private func switchTurn() {
        isFirstPlayerTurn.toggle()
    }
}
