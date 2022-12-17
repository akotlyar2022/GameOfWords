//
//  ContentView.swift
//  GameOfWords
//
//  Created by macbook on 13.08.22.
//

import SwiftUI

struct StartView: View {
    
    @State var bigWord = ""
    @State var player1 = ""
    @State var player2 = ""
    
    @State var isShowedGame = false
    @State var isAlertPresented = false
    
    var body: some View {
        
        VStack{
        
            TitleText(text: "GAME OF WORDS")
            
            WordsTextField(word: $bigWord, placeholder: "ВВЕДИТЕ БОЛЬШОЕ СЛОВО")
                .padding(20)
                .padding(.top, 32)
                .font(.title)
                .foregroundColor(.green)
            
            WordsTextField(word: $player1, placeholder: "Игрок 1")
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .font(.title2)
                .foregroundColor(.blue)

            WordsTextField(word: $player2, placeholder: "Игрок 2")
                .cornerRadius(12)
                .padding(.horizontal, 20)
            
        
        Button {
            if bigWord.count > 7 {
                isShowedGame.toggle()
            } else {
                self.isAlertPresented.toggle()
            }
            
        } label: {
            Text("СТАРТ")
                .font(.largeTitle.italic().bold())
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal, 60)
                .background(Color("Orange"))
                .cornerRadius(12)
                .padding(.top)
            }

            
        }.background(Image("background"))
            .alert("Основное игровое слово слишком короткое", isPresented: $isAlertPresented, actions: {
                Text("OK!")
            })
            .fullScreenCover(isPresented: $isShowedGame){
                
                let name1 = player1 == "" ? "Игрок 1" : player1
                let name2 = player2 == "" ? "Игрок 2" : player2
                
                
                let player1 = Player(name: name1)
                let player2 = Player(name: name2)

                let gameViewModel = GameViewModel(player1: player1, player2: player2, word: bigWord)
                
                GameView(viewModel: gameViewModel)
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
