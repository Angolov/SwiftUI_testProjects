//
//  AdminOrdersView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 14.08.2022.
//

import SwiftUI

// MARK: - AdminOrdersView struct

struct AdminOrdersView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = AdminOrdersViewModel()
    
    // MARK: - Body
    
    var body: some View {
        List {
            ForEach(viewModel.orders, id: \.id) { order in
                let viewModel = AdminOrderViewModel(order: order)
                NavigationLink(destination: AdminOrderView(viewModel: viewModel)) {
                    OrderCell(order: order)
                }
            }
        }
        .navigationTitle("Все заказы")
        .listStyle(.plain)
        .onAppear {
            viewModel.getOrders()
        }
    }
}

struct AdminOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        AdminOrdersView()
    }
}
