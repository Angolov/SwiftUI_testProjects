//
//  CatalogueView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

// MARK: - CatalogueView struct
struct CatalogueView: View {
    
    // MARK: - Properties
    
    let layout = [GridItem(.adaptive(minimum: screen.width / 2.2))]
    
    // MARK: - Body
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            Section("Популярное") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layout, spacing: 16) {
                        productCells
                    }
                    .padding(8)
                    .padding(.vertical, 8)
                }
            }
            
            Section("Пицца") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layout) {
                        productCells
                    }
                    .padding(8)
                    .padding(.vertical, 8)
                }
            }
            
            
        }
        .navigationTitle("Каталог")
    }
    
    // MARK: - Private methods
    
    private var productCells: some View {
        ForEach(CatalogueViewModel.shared.products, id: \.id) { item in
            NavigationLink {
                let viewModel = ProductDetailViewModel(product: item)
                ProductDetailView(viewModel: viewModel)
            } label: {
                ProductCell(product: item)
                    .foregroundColor(.black)
            }
        }
    }
}

struct Catalogue_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}
