//
//  PasswordField.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

// MARK: - PasswordField struct

struct PasswordField: View {
    
    // MARK: - Properties
    
    var placeholder: String
    @Binding var text: String
    
    // MARK: - Body
    
    var body: some View {
        SecureField("Введите пароль", text: $text)
            .padding()
            .background(Color("WhiteAlpha"))
            .cornerRadius(12)
    }
}

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordField(placeholder: "", text: .constant(""))
    }
}
