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
                Button {
                    print("Quit button tapped")
                    showConfirmDialog = true
                } label: {
                    Text("Выход")
                        .padding(6)
                        .padding(.horizontal, 16)
                        .background(Color("Orange"))
                        .cornerRadius(12)
                        .padding()
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-Bold", size: 18))
                }
                
                Spacer()
            }
            
            Text(viewModel.originalWord)
                .font(.custom("AvenirNext-Bold", size: 30))
                .foregroundColor(.white)
            
            HStack(spacing: 12) {
                
                VStack {
                    Text("\(viewModel.firstPlayer.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    
                    Text("\(viewModel.firstPlayer.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }
                .padding(20)
                .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                .background(Color("FirstPlayer"))
                .cornerRadius(26)
                .shadow(color: viewModel.isFirstPlayerTurn ? .red : .clear,
                        radius: 4,
                        x: 0,
                        y: 0)
                
                VStack {
                    Text("\(viewModel.secondPlayer.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    
                    Text("\(viewModel.secondPlayer.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }
                .padding(20)
                .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                .background(Color("SecondPlayer"))
                .cornerRadius(26)
                .shadow(color: viewModel.isFirstPlayerTurn ? .clear : .purple,
                        radius: 4,
                        x: 0,
                        y: 0)
            }
            
            WordTextField(word: $playerWord, placeholder: "Ваше слово")
                .padding(.horizontal)
            
            Button {
                
                print("Ready button tapped")
                
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
                
            } label: {
                Text("Готово")
                    .padding(12)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color("Orange"))
                    .cornerRadius(12)
                    .font(.custom("AvenirNext-Bold", size: 26))
                    .padding(.horizontal)
            }
            
            List {
                ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                    WordCell(word: self.viewModel.words[item])
                        .background(item % 2 == 0 ? Color("FirstPlayer") : Color("SecondPlayer"))
                        .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .background(Image("background"))
        .confirmationDialog("Вы уверены, что хотите завершить игру?",
                            isPresented: $showConfirmDialog, titleVisibility: .visible) {
            Button(role: .destructive) {
                self.dismiss()
            } label: {
                Text("Да")
            }
            
            Button(role: .cancel) {} label: {
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(firstPlayer: Player(name: "Вася"),
                                          secondPlayer: Player(name: "Петя"),
                                          originalWord: "Рекогносцировка"))
    }
}
