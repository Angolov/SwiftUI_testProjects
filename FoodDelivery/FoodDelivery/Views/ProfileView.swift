//
//  ProfileView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

// MARK: - ProfileView struct

struct ProfileView: View {
    
    // MARK: - Properties
    
    @State var showAvatarSelectionDialog = false
    @State var showQuitDialog = false
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: ProfileViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 16) {
                avatarImage
                    .onTapGesture(perform: avatarTapped)
                    
                contactsText
                
                Spacer()
            }
            .padding(.horizontal)
            
            addressText
                .padding(.horizontal)
            
            ordersList
            
            quitButton
                .padding()
            
        }
        .padding(.top, 16)
        .navigationTitle("Профиль")
        .onAppear {
            viewModel.getProfile()
            viewModel.getOrders()
        }
        .onSubmit {
            viewModel.setProfile()
        }
        .confirmationDialog(Text("Выбор фото"),
                            isPresented: $showAvatarSelectionDialog,
                            titleVisibility: .visible) {
            Button("Из галереи", action: getPhotoFromLibrary)
            Button("С камеры", action: getPhotoFromCamera)
            Button("Отмена", role: .cancel, action: {})
        }
        .confirmationDialog("Вы действительно хотите выйти?",
                            isPresented: $showQuitDialog,
                            titleVisibility: .visible) {
            Button("Да", role: .destructive, action: quitConfirmTapped)
            Button("Нет", role: .cancel, action: {})
        }
    }
}

// MARK: - UI elements

extension ProfileView {
    
    private var avatarImage: some View {
        Image("UserImage")
            .resizable()
            .frame(width: 80, height: 80)
            .padding(8)
            .background(Color("LightGray"))
            .clipShape(Circle())
    }
    
    private var contactsText: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("Имя", text: $viewModel.profile.name)
                .font(.body.bold())
            
            HStack {
                Text("+7")
                TextField("Телефон", value: $viewModel.profile.phone, format: .number)
            }
        }
    }
    
    private var addressText: some View {
        VStack(alignment: .leading) {
            Text("Адрес доставки:")
                .font(.body.bold())
            
            TextField("Адрес", text: $viewModel.profile.address)
        }
    }
    
    private var ordersList: some View {
        List {
            if viewModel.orders.count == 0 {
                Text("Ваши заказы будут тут")
            } else {
                ForEach(viewModel.orders, id: \.id) { order in
                    OrderCell(order: order)
                }
            }
        }
        .listStyle(.plain)
    }
    
    private var quitButton: some View {
        Button(action: quitButtonTapped) {
            Text("Выйти")
                .font(.title3)
                .bold()
                .padding(12)
                .padding(.horizontal)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(20)
        }
    }
}

// MARK: - Actions

extension ProfileView {
    
    private func avatarTapped() {
        showAvatarSelectionDialog = true
    }
    
    private func getPhotoFromLibrary() {
        
    }
    
    private func getPhotoFromCamera() {
        
    }
    
    private func quitButtonTapped() {
        showQuitDialog = true
    }
    
    private func quitConfirmTapped() {
        viewModel.signOut()
        presentationMode.wrappedValue.dismiss()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        
        let name = "Имя Фамилия"
        let phone = 9195191919
        let address = "Россия, Московская область, г. Владимир, ул. Ленина д.2, кв.10"
        let viewModel = ProfileViewModel(profile: AppUser(id: "", name: name, phone: phone, address: address))
        
        ProfileView(viewModel: viewModel)
    }
}
