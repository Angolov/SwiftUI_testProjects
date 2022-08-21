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
    
    @StateObject private var viewModel = CatalogueViewModel()
    let layout = [GridItem(.adaptive(minimum: screen.width / 2.2))]
    
    // MARK: - Body
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            Section("Популярное") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layout, spacing: 16) {
                        ForEach(viewModel.popularProducts, id: \.id) { item in
                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(8)
                    .padding(.vertical, 8)
                }
            }
            
            Section("Пицца") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layout) {
                        ForEach(viewModel.allProducts, id: \.id) { item in
                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(8)
                    .padding(.vertical, 8)
                }
            }
            
            
        }
        .navigationTitle("Каталог")
        .onAppear {
            viewModel.getProducts()
        }
    }
}

struct Catalogue_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}
