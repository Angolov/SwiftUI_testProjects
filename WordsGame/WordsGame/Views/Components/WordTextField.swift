//
//  WordTextField.swift
//  WordsGame
//
//  Created by Антон Головатый on 05.08.2022.
//

import SwiftUI

struct WordTextField: View {
    
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

struct WordTextField_Previews: PreviewProvider {
    static var previews: some View {
        WordTextField(word: .constant(""), placeholder: "Введите слово")
    }
}
