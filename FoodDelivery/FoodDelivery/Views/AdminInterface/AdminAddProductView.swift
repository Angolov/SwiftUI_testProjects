//
//  AdminAddProductView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 17.08.2022.
//

import SwiftUI

struct AdminAddProductView: View {
    
    @State private var showImagePicker = false
    @State private var productImage = UIImage()
    @State private var productTitle = ""
    @State private var productPrice: Int? = nil
    @State private var productDescript = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: productImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: screen.width - 50,
                       maxHeight: screen.width - 50)
                .background(backgroundView)
                .cornerRadius(25)
                .onTapGesture {
                    showImagePicker = true
                }
            TextField("Название нового продукта", text: $productTitle)
                .padding()
            TextField("Цена продукта", value: $productPrice, format: .number)
                .keyboardType(.numberPad)
                .padding()
            TextField("Описание нового продукта", text: $productDescript)
                .padding()
            
            Spacer()
            
            Button("Сохранить товар", action: saveProductButtonTapped)
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(18)
        }
        .padding()
        .navigationTitle("Добавить товар")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $productImage)
        }
    }
    
    private var backgroundView: some View {
        ZStack {
            Color("LightGray")
            Image(systemName: "shippingbox")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100, maxHeight: 100)
        }
    }
    
    private func saveProductButtonTapped() {
        let newProduct = Product(id: "",
                                 title: productTitle,
                                 imageUrl: "",
                                 price: productPrice ?? 0,
                                 description: productDescript)
        
        print("Product \(newProduct.title) saved")
    }
}

struct AdminAddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AdminAddProductView()
    }
}
