//
//  EmailField.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

// MARK: - EmailField struct

struct EmailField: View {
    
    // MARK: - Properties
    
    @Binding var text: String
    
    // MARK: - Body
    
    var body: some View {
        TextField("Введите email", text: $text)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .padding()
            .background(Color("WhiteAlpha"))
            .cornerRadius(12)
    }
}

struct EmailField_Previews: PreviewProvider {
    static var previews: some View {
        EmailField(text: .constant(""))
    }
}
