//
//  ProductDetailView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product: Product
    
    var body: some View {
        Text("\(product.title)")
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(id: "1",
                                           title: "Пицца Маргарита",
                                           imageUrl: "PizzaMargarita",
                                           price: 450,
                                           description: "Самая простая пицца"))
    }
}
