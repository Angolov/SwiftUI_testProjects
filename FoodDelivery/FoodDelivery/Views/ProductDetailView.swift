//
//  ProductDetailView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

// MARK: - ProductDetailView struct

struct ProductDetailView: View {
    
    // MARK: - Properties
    
    var viewModel: ProductDetailViewModel
    @State var size = "Маленькая"
    @State var count = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    var productImage: UIImage {
        guard let baseImage = UIImage(named: "PizzaMargarita") else { return UIImage() }
        return UIImage(data: viewModel.product.image) ?? baseImage
    }
    
    // MARK: - Body
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                
                VStack(alignment: .center) {
                    Image(uiImage: productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: screen.width - 50,
                               maxHeight: screen.width - 50)
                        .cornerRadius(25)
                        .padding()
                }
                
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
            
            Button(action: addToCartButtonTapped) {
                Text("Добавить в корзину")
                    .padding()
                    .padding(.horizontal, 30)
                    .foregroundColor(Color("DarkBrown"))
                    .font(.title3.bold())
                    .background(LinearGradient(colors: [Color("Yellow"), Color("Orange")],
                                               startPoint: .leading,
                                               endPoint: .trailing))
                    .cornerRadius(15)
            }
            
            Spacer()
        }
        .navigationTitle("Информация о продукте")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Private methods
    
    private func addToCartButtonTapped() {
        
        let product = Product(id: viewModel.product.id,
                              title: "\(viewModel.product.title) \(size.lowercased())",
                              price: viewModel.getPrice(size: size),
                              description: viewModel.product.description)
        
        let position = Position(id: UUID().uuidString,
                                product: product,
                                count: self.count)
        
        CartViewModel.shared.addPosition(position)
        presentationMode.wrappedValue.dismiss()
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let testProduct = Product(id: "1",
                                  title: "Пицца Маргарита",
                                  price: 450,
                                  description: "Самая простая пицца")
        let viewModel = ProductDetailViewModel(product: testProduct)
        ProductDetailView(viewModel: viewModel)
    }
}
