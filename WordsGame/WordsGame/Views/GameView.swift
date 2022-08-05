//
//  GameView.swift
//  WordsGame
//
//  Created by Антон Головатый on 05.08.2022.
//

import SwiftUI

struct GameView: View {
    
    @State private var playerWord = ""
    @ObservedObject var viewModel: GameViewModel
    
    @State private var showConfirmDialog = false
    @State private var showAlertMessage = false
    @State private var alertText = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                exitButton
                    .padding()
                Spacer()
            }
            
            titleWord
            
            HStack(spacing: 12) {
                PlayerScoreLabel(viewModel: viewModel, playerNumber: 1)
                PlayerScoreLabel(viewModel: viewModel, playerNumber: 2)
            }
            
            WordTextField(word: $playerWord, placeholder: "Ваше слово")
                .padding(.horizontal)
            
            readyButton
                .padding(.horizontal)
            
            wordsList
        }
        .background(Image("background"))
        .confirmationDialog("Вы уверены, что хотите завершить игру?",
                            isPresented: $showConfirmDialog,
                            titleVisibility: .visible) {
            Button(role: .destructive, action: dismissButtonTapped) {
                Text("Да")
            }
            
            Button(role: .cancel, action: {}) {
                Text("Нет")
            }
        }
        .alert("Произошла ошибка", isPresented: $showAlertMessage) {
            Button(action: {}) {
                Text("Ок, понял...")
            }
        } message: {
            Text(alertText)
        }

    }
}

// MARK: UI elements

extension GameView {
    
    private var exitButton: some View {
        Button {
            showConfirmDialog = true
        } label: {
            Text("Выход")
                .foregroundColor(.white)
                .font(.custom("AvenirNext-Bold", size: 18))
                .padding(6)
                .padding(.horizontal, 16)
                .background(Color("Orange"))
                .cornerRadius(12)
        }
    }
    
    private var titleWord: some View {
        Text(viewModel.originalWord)
            .font(.custom("AvenirNext-Bold", size: 30))
            .foregroundColor(.white)
    }
    
    private var readyButton: some View {
        Button(action: readyButtonTapped) {
            Text("Готово")
                .padding(12)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color("Orange"))
                .cornerRadius(12)
                .font(.custom("AvenirNext-Bold", size: 26))
        }
    }
    
    private var wordsList: some View {
        List {
            ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                let cellBackgroundColor = getCellBackgroundColor(index: item)
                WordCell(word: self.viewModel.words[item])
                    .background(cellBackgroundColor)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            }
        }
        .listRowBackground(Color.clear)
        .listStyle(.plain)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: Private methods

extension GameView {
    
    private func dismissButtonTapped() {
        self.dismiss()
    }
    
    private func readyButtonTapped() {
        do {
            try viewModel.finalizeTurnWith(word: playerWord)
            playerWord = ""
        }
        catch (let error) {
            if let error = error as? WordError {
                alertText = error.description
            } else {
                alertText = "Что-то пошло совсем не так..."
            }
            showAlertMessage = true
        }
    }
    
    private func getCellBackgroundColor(index: Int) -> Color {
        var backgroundColor = Color.clear
        
        if self.viewModel.isFirstPlayerTurn {
            backgroundColor = index % 2 == 1 ? Color("FirstPlayer") : Color("SecondPlayer")
        } else {
            backgroundColor = index % 2 == 0 ? Color("FirstPlayer") : Color("SecondPlayer")
        }
        
        return backgroundColor
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(firstPlayer: Player(name: "Вася"),
                                          secondPlayer: Player(name: "Петя"),
                                          originalWord: "Рекогносцировка"))
    }
}
