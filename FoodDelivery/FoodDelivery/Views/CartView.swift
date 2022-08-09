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
                        Button {
                            viewModel.positions.removeAll { pos in
                                pos.product.id == position.product.id
                            }
                        } label: {
                            Text("Удалить")
                        }
                        .tint(.red)

                    }
            }
            .listStyle(.plain)
            
            HStack {
                Text("ИТОГО: ")
                    .fontWeight(.bold)
                Spacer()
                Text("\(viewModel.totalCost) ₽")
                    .fontWeight(.bold)
            }
            .padding()
            
            HStack {
                Button {
                    print("Cancel order tapped")
                } label: {
                    Text("Отменить")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(24)
                }
                
                Button {
                    print("Place order tapped")
                } label: {
                    Text("Заказать")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(24)
                }
            }
            .padding()
        }
        .navigationTitle("Корзина")
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel.shared)
    }
}
