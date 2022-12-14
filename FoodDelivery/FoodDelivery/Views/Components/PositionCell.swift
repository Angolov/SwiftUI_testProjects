//
//  PositionCell.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 09.08.2022.
//

import SwiftUI

// MARK: - PositionCell struct

struct PositionCell: View {
    
    // MARK: - Properties
    
    let position: Position
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Text(position.product.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("\(position.count) шт.")
            
            Text("\(position.cost) ₽")
                .frame(width: 85, alignment: .trailing)
        }
        .padding(.horizontal)
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(position: Position(id: UUID().uuidString,
                                        product: Product(id: "1",
                                                         title: "Пицца Маргарита",
                                                         price: 450,
                                                         description: "Самая простая пицца"),
                                        count: 3))
    }
}
