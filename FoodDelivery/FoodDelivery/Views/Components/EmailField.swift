//
//  EmailField.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

struct EmailField: View {
    
    @Binding var text: String
    
    var body: some View {
        TextField("Введите email", text: $text)
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
