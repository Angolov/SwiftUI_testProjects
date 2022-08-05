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
    @State private var showAlert = false
    
    var body: some View {
        
        VStack {
            
            TitleText(text: "Words Game")
            
            WordTextField(word: $originalWord, placeholder: "Введите длинное слово")
                .padding(20)
                .padding(.top, 32)
            
            WordTextField(word: $firstPlayerName, placeholder: "Игрок 1")
                .padding(.horizontal, 20)
            
            WordTextField(word: $secondPlayerName, placeholder: "Игрок 2")
                .padding(.horizontal, 20)
            
            startButton
                .padding(.top)
                
        }
        .background(Image("background"))
        .fullScreenCover(isPresented: $showGameView) {
            prepareAndReturnGameView()
        }
        .alert("Ваше слово слишком короткое!", isPresented: $showAlert) {
            Text("ОК")
        }
    }
}

extension StartView {
    
    private var startButton: some View {
        Button {
            if originalWord.count > 7 {
                showGameView.toggle()
            } else {
                showAlert = true
            }
        } label: {
            Text("Старт")
                .font(.custom("AvenirNext-Bold", size: 30))
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal, 64)
                .background(Color("FirstPlayer"))
                .cornerRadius(12)
        }
    }
    
    private func prepareAndReturnGameView() -> some View {
        let name1 = firstPlayerName == "" ? "Игрок 1" : firstPlayerName
        let name2 = secondPlayerName == "" ? "Игрок 2" : secondPlayerName
        
        let firstPlayer = Player(name: name1)
        let secondPlayer = Player(name: name2)
        
        let gameViewModel = GameViewModel(firstPlayer: firstPlayer,
                                          secondPlayer: secondPlayer,
                                          originalWord: originalWord)
        
        return GameView(viewModel: gameViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
