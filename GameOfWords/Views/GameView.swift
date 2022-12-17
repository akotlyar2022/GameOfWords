//
//  GameView.swift
//  GameOfWords
//
//  Created by macbook on 13.08.22.
//

import SwiftUI

struct GameView: View {
    
    @State private var word = ""
    var viewModel: GameViewModel
    @State private var confirmPresent = false
    @State private var isAlertPresent = false
    @State var alertText = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                Button {
                    confirmPresent.toggle()
                } label: {
                    Text("Выход")
                        .padding(6)
                        .padding(.horizontal)
                        .background(Color("Orange"))
                        .cornerRadius(12)
                        .padding(6)
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-Bold", size: 18))
                    
                }
                Spacer()
            }
            Text(viewModel.word)
                .font(.custom("AvenirNext-Bold", size: 30))
                .foregroundColor(.white)
            
            HStack(spacing: 12) {
                
                VStack {
                    Text("\(viewModel.player1.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text("\(viewModel.player1.name)")
                        .font(.custom("AvenirNext-Bold", size: 25))
                        .foregroundColor(.white)
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(25)
                    .shadow(color: viewModel.isFirst ? .red : .clear, radius: 4, x: 5, y: 5)
                
                VStack {
                    Text("\(viewModel.player2.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text("\(viewModel.player2.name)")
                        .font(.custom("AvenirNext-Bold", size: 25))
                        .foregroundColor(.white)
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("SecondPlayer"))
                    .cornerRadius(25)
                    .shadow(color: viewModel.isFirst ? .clear : .red, radius: 4, x: 5, y: 5)
                
            }
            
            WordsTextField(word: $word, placeholder: "Ваше слово:")
                .padding(.horizontal)
            Button {
                
                var score = 0
                do {
                    try score =  viewModel.check(word: word)
                } catch WordError.beforeWord {
                    alertText = "Прояви фантазию! Придумай новое слово, которого еще не было ранее"
                    isAlertPresent.toggle()
                    
                } catch WordError.theSameWord {
                    alertText = "Думаешь самый умный? Составленное слово не должно быть исходным словом!"
                    isAlertPresent.toggle()
                } catch WordError.littleWord {
                    alertText = "Слишком короткое слово"
                    isAlertPresent.toggle()
                } catch WordError.wrongWord {
                    alertText = "Такое слово не может быть составлено"
                    isAlertPresent.toggle()
                } catch {
                    alertText = "Неизвестная ошибка"
                    isAlertPresent.toggle()
                }
                
               
                if score > 0 {
                self.word = ""
                }
            } label: {
                Text("Готово!")
                    .padding(12)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color("Orange"))
                    .cornerRadius(12)
                    .font(.custom("AvenirNext-Bold", size: 25))
                    .padding(.horizontal)
                    
            }
            
            List{
                ForEach(0..<self.viewModel.words.count, id: \.description) {item in
                    WordCell(word: self.viewModel.words[item])
                        .background(item % 2 == 0 ? Color ("FirstPlayer") : Color("SecondPlayer"))
                        .listRowInsets(EdgeInsets())
                }
            }.listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }.background(Image("background"))
            .confirmationDialog("Вы уверенны, что хотите завершить игру?", isPresented: $confirmPresent, titleVisibility: .visible) {
                
                Button(role: .destructive) {
                    self.dismiss()
                } label: {
                    Text("Да")
                }
                
                Button(role: .cancel) { } label: {
                    Text("Нет")
                }
                
            }
        
            .alert(alertText, isPresented: $isAlertPresent) {
                Text("OK!")
            }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Alex"), player2: Player(name: "Max"), word: "Рекогносцировка"))
    }
}
