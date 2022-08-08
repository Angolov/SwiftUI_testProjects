//
//  PasswordField.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

struct PasswordField: View {
    
    var placeholder: String
    @Binding var text: String
    
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
