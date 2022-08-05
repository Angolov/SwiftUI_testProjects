//
//  PlayerScoreLabel.swift
//  WordsGame
//
//  Created by Антон Головатый on 05.08.2022.
//

import SwiftUI

struct PlayerScoreLabel: View {
    
    @ObservedObject var viewModel: GameViewModel
    let playerNumber: Int
    
    var body: some View {
        VStack {
            Text("\(playerScore)")
                .font(.custom("AvenirNext-Bold", size: 60))
                .foregroundColor(.white)
            
            Text("\(playerName)")
                .font(.custom("AvenirNext-Bold", size: 24))
                .foregroundColor(.white)
        }
        .padding(20)
        .frame(width: screen.width / 2.2, height: screen.width / 2.2)
        .background(backgroundColor)
        .cornerRadius(26)
        .shadow(color: shadowColor, radius: 4, x: 0,y: 0)
    }
}

extension PlayerScoreLabel {
    
    private var playerScore: Int {
        playerNumber == 1 ? viewModel.firstPlayer.score : viewModel.secondPlayer.score
    }
    
    private var playerName: String {
        playerNumber == 1 ? viewModel.firstPlayer.name : viewModel.secondPlayer.name
    }
    
    private var backgroundColor: Color {
        Color(playerNumber == 1 ? "FirstPlayer" : "SecondPlayer")
    }
    
    private var shadowColor: Color {
        if playerNumber == 1 {
            return viewModel.isFirstPlayerTurn ? .red : .clear
        } else {
            return viewModel.isFirstPlayerTurn ? .clear : .purple
        }
    }
}

struct PlayerScoreLabel_Previews: PreviewProvider {
    static var previews: some View {
        PlayerScoreLabel(viewModel: GameViewModel(firstPlayer: Player(name: "Вася"),
                                                  secondPlayer: Player(name: "Петя"),
                                                  originalWord: "Рекогносцировка"), playerNumber: 1)
    }
}
