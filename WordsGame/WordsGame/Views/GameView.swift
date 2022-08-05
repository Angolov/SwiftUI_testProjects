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
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            HStack {
                Button {
                    print("Quit button tapped")
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
                .shadow(color: .red,
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
                .shadow(color: .purple,
                        radius: 4,
                        x: 0,
                        y: 0)
            }
            
            WordTextField(word: $playerWord, placeholder: "Ваше слово")
                .padding(.horizontal)
            
            Button {
                let score = viewModel.check(word: playerWord)
                print("Ready button tapped")
                if score > 0 {
                    playerWord = ""
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
                
            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .background(Image("background"))
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(firstPlayer: Player(name: "Вася"),
                                          secondPlayer: Player(name: "Петя"),
                                          originalWord: "Рекогносцировка"))
    }
}
