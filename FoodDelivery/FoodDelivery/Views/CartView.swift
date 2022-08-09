//
//  CartView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var viewModel: CartViewModel
    
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
        Button("Отменить", action: cancelOrderTapped)
            .font(.body.bold())
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(24)
    }
    
    private var orderButton: some View {
        Button("Заказать", action: confirmOrderTapped)
            .font(.body.bold())
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .cornerRadius(24)
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
        print("Place order tapped")
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel.shared)
    }
}
