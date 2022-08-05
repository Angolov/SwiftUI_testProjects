//
//  ContentView.swift
//  WordsGame
//
//  Created by Антон Головатый on 05.08.2022.
//

import SwiftUI

struct StartView: View {
    
    @State private var originalWord = ""
    @State private var firstPlayerName = ""
    @State private var secondPlayerName = ""
    
    @State private var showGameView = false
    
    var body: some View {
        
        VStack {
            
            TitleText(text: "Words Game")
            
            WordTextField(word: $originalWord, placeholder: "Введите длинное слово")
                .padding(20)
                .padding(.top, 32)
            
            WordTextField(word: $firstPlayerName, placeholder: "Игрок 1")
                .cornerRadius(12)
                .padding(.horizontal, 20)
            
            WordTextField(word: $secondPlayerName, placeholder: "Игрок 2")
                .cornerRadius(12)
                .padding(.horizontal, 20)
            
            Button {
                print("Start button tapped")
                showGameView.toggle()
            } label: {
                Text("Старт")
                    .font(.custom("AvenirNext-Bold", size: 30))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 64)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(12)
                    .padding(.top)
            }
        }
        .background(Image("background"))
        .fullScreenCover(isPresented: $showGameView) {
            
            let firstPlayer = Player(name: firstPlayerName)
            let secondPlayer = Player(name: secondPlayerName)
            
            let gameViewModel = GameViewModel(firstPlayer: firstPlayer,
                                              secondPlayer: secondPlayer,
                                              originalWord: originalWord)
            
            GameView(viewModel: gameViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
