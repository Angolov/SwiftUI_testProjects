//
//  ProductCell.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

// MARK: - ProductCell struct

struct ProductCell: View {
    
    // MARK: - Properties
    
    var product: Product
    private var productImage: UIImage {
        guard let baseImage = UIImage(named: "PizzaMargarita") else { return UIImage() }
        return UIImage(data: product.image) ?? baseImage
    }
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(spacing: 2) {
            Image(uiImage: productImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: screen.width * 0.45)
                .clipped()
                .cornerRadius(16)
            
            HStack {
                Text(product.title)
                    .font(.custom("AvenirNext-regular", size: 12))
                Spacer()
                Text("\(product.price) ₽")
                    .font(.custom("AvenirNext-bold", size: 12))
            }
            .padding(.horizontal, 6)
            .padding(.bottom, 6)
        }
        .frame(width: screen.width * 0.45, height: screen.width * 0.55, alignment: .center)
        .background(.white)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product(id: "1",
                                     title: "Пицца Маргарита",
                                     imageUrl: "PizzaMargarita",
                                     price: 450,
                                     description: "Самая простая пицца"))
    }
}
