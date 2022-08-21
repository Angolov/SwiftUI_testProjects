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
        }
        .padding()
        
        Picker(selection: $viewModel.order.status) {
            ForEach(OrderStatus.allCases, id: \.self) { status in
                Text(status.rawValue)
            }
        } label: {
            Text("Статус заказа")
        }
        .pickerStyle(.segmented)
        .onChange(of: viewModel.order.status) { newStatus in
            DatabaseService.shared.setOrder(order: viewModel.order) { result in
                switch result {
                    
                case .success(let order):
                    print(order.status)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        List {
            ForEach(viewModel.order.positions, id: \.id) { position in
                PositionCell(position: position)
            }
            Text("Итого: \(viewModel.order.total)")
                .font(.title3.bold())
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

