//
//  OrderCell.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 14.08.2022.
//

import SwiftUI

struct OrderCell: View {
    
    @State var order: Order
    
    var body: some View {
        HStack {
            Text("\(order.date)")
            Text("\(order.cost)")
                .bold()
                .frame(width: 90)
            Text("\(order.status.rawValue)")
                .frame(width: 100)
                .foregroundColor(.green)
        }
    }
}

struct OrderCell_Previews: PreviewProvider {
    static var previews: some View {
        OrderCell(order: Order(userID: "", status: .new))
    }
}
