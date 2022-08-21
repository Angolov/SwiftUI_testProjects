//
//  CartView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

// MARK: - CartView struct

struct CartView: View {
    
    // MARK: - Properties
    
    @State private var showOrderMessage = false
    @StateObject var viewModel: CartViewModel
    
    // MARK: - Body
    
    var body: some View {
        
        VStack {
            List(viewModel.positions) { position in
                PositionCell(position: position)
                    .swipeActions {
                        Button("Удалить") {
                            deleteSwipeAction(position: position)
                        }
                        .tint(.red)
                    }
            }
            .listStyle(.plain)
            
            totalCostText
                .padding()
            
            HStack {
                cancelButton
                orderButton
            }
            .padding()
        }
        .navigationTitle("Корзина")
        .alert(viewModel.messageTitle, isPresented: $showOrderMessage) {
            Button("OK", action: {})
        } message: {
            Text(viewModel.messageText)
        }

    }
}

// MARK: - UI elements

extension CartView {
    
    private var totalCostText: some View {
        HStack {
            Text("ИТОГО: ")
                .fontWeight(.bold)
            Spacer()
            Text("\(viewModel.totalCost) ₽")
                .fontWeight(.bold)
        }
    }
    
    private var cancelButton: some View {
        Button(action: cancelOrderTapped) {
            Text("Отменить")
                .font(.body.bold())
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(24)
        }
    }
    
    private var orderButton: some View {
        Button(action: confirmOrderTapped) {
            Text("Заказать")
                .font(.body.bold())
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(24)
        }
    }
}

// MARK: - Actions

extension CartView {
    
    private func deleteSwipeAction(position: Position) {
        viewModel.positions.removeAll { pos in
            pos.product.id == position.product.id
        }
    }
    
    private func cancelOrderTapped() {
        print("Cancel order tapped")
    }
    
    private func confirmOrderTapped() {
        viewModel.placeOrder {
            showOrderMessage = true
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel.shared)
    }
}
