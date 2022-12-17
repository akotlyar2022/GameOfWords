//
//  TitleText.swift
//  GameOfWords
//
//  Created by macbook on 13.08.22.
//

import SwiftUI

struct TitleText: View {
    
    @State var text: String
    
    var body: some View {
        Text(text)
        
            .padding()
            .font(.largeTitle.italic().bold())
            .cornerRadius(15)
            .frame(maxWidth: .infinity)
            .background(Color("Orange"))
            .foregroundColor(.white)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "ДРАКОНОВЕДЕНИЕ")
    }
}
