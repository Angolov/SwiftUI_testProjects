//
//  AdminAddProductView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 17.08.2022.
//

import SwiftUI

// MARK: - AdminAddProductView struct

struct AdminAddProductView: View {
    
    // MARK: - Properties
    
    @State private var showImagePicker = false
    @State private var productImage = UIImage()
    @StateObject private var viewModel = AdminAddProductViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    
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
            TextField("Название нового продукта", text: $viewModel.productTitle)
                .padding()
            TextField("Цена продукта", value: $viewModel.productPrice, format: .number)
                .keyboardType(.numberPad)
                .padding()
            TextField("Описание нового продукта", text: $viewModel.productDescript)
                .padding()
            
            Spacer()
            
            Button(action: saveProductButtonTapped) {
                Text("Сохранить товар")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(18)
            }
        }
        .padding()
        .navigationTitle("Добавить товар")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $productImage)
        }
    }
    
    // MARK: - UI elements
    
    private var backgroundView: some View {
        ZStack {
            Color("LightGray")
            Image(systemName: "shippingbox")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100, maxHeight: 100)
        }
    }
    
    // MARK: - Private methods
    
    private func saveProductButtonTapped() {
        let imageData = productImage.jpegData(compressionQuality: 0.15)
        viewModel.saveProductToDatabase(imageData: imageData) { result in
            switch result {
            case .success(let string):
                print(string)
                self.presentationMode.wrappedValue.dismiss()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct AdminAddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AdminAddProductView()
    }
}
