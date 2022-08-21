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
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAddProductView = false
    
    // MARK: - Body
    
    var body: some View {
        VStack {
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
            .refreshable {
                print("on refresh")
                viewModel.getOrders()
            }
            
            NavigationLink(destination: AdminAddProductView()) {
                Text("Добавить товар")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(18)
                    .padding(.horizontal, 8)
            }
            
            Button(action: exitButtonTapped) {
                Text("Выйти")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(18)
                    .padding(.horizontal, 8)
            }
        }
    }
    
    private func exitButtonTapped() {
        viewModel.signOut()
        presentationMode.wrappedValue.dismiss()
    }
}

struct AdminOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        AdminOrdersView()
    }
}
