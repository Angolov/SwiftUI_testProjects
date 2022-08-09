//
//  ProductDetailView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

struct ProductDetailView: View {
    
    var viewModel: ProductDetailViewModel
    @State var size = "Маленькая"
    @State var count = 1
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                Image("\(viewModel.product.imageUrl)")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 260)
                    .aspectRatio(contentMode: .fit)
                HStack {
                    Text("\(viewModel.product.title)")
                        .font(.title2.bold())
                    Spacer()
                    Text("\(viewModel.getPrice(size: size)) ₽")
                        .font(.title2)
                }
                .padding(.horizontal)
                
                Text("\(viewModel.product.description)")
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                
                HStack {
                    Stepper("Количество", value: $count, in: 1...10)
                    
                    Text("\(self.count)")
                        .padding(.leading, 32)
                }
                .padding(.horizontal)
                
                Picker("Размер пиццы", selection: $size) {
                    
                    ForEach(viewModel.sizes, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            
            Button {
                print("Add to cart tapped")
            } label: {
                Text("Добавить в корзину")
            }
            .padding()
            .padding(.horizontal, 30)
            .foregroundColor(Color("DarkBrown"))
            .font(.title3.bold())
            .background(LinearGradient(colors: [Color("Yellow"), Color("Orange")],
                                       startPoint: .leading,
                                       endPoint: .trailing))
            .cornerRadius(15)

            Spacer()
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let testProduct = Product(id: "1",
                                  title: "Пицца Маргарита",
                                  imageUrl: "PizzaMargarita",
                                  price: 450,
                                  description: "Самая простая пицца")
        let viewModel = ProductDetailViewModel(product: testProduct)
        ProductDetailView(viewModel: viewModel)
    }
}
