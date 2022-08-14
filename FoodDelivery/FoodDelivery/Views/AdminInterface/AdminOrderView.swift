//
//  AdminOrderView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 14.08.2022.
//

import SwiftUI

// MARK: - AdminOrderView struct

struct AdminOrderView: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: AdminOrderViewModel
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("ФИО: \(viewModel.user.name)")
                .font(.title3.bold())
            Text("Телефон: \(viewModel.user.phone)")
                .bold()
            Text("Адрес: \(viewModel.user.address)")
            
            List {
                ForEach(viewModel.order.positions, id: \.id) { position in
                    PositionCell(position: position)
                }
                Text("Итого: \(viewModel.order.cost)")
                    .font(.title3.bold())
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}
