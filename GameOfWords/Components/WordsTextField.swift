//
//  WordTextField.swift
//  GameOfWords
//
//  Created by macbook on 13.08.22.
//

import SwiftUI

struct WordsTextField: View {
    @State var word: Binding<String>
    
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: word)
                .font(.title2)
                .padding()
                .background(.white)
                .cornerRadius(12)
    }
}


