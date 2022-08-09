//
//  ProfileView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @State var showAvatarSelectionDialog = false
    @State var showQuitDialog = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 16) {
                avatar
                    .onTapGesture(perform: avatarTapped)
                    
                contacts
                
                Spacer()
            }
            .padding(.horizontal)
            
            address
            
            // Таблица с заказами
            List {
                Text("Ваши заказы будут тут")
            }
            .listStyle(.plain)
            
            quitButton
                .padding()
            
        }
        .padding(.top, 16)
        .navigationTitle("Профиль")
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
    
    private var avatar: some View {
        Image("UserImage")
            .resizable()
            .frame(width: 80, height: 80)
            .padding(8)
            .background(Color("LightGray"))
            .clipShape(Circle())
    }
    
    private var contacts: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Имя пользователя")
                .bold()
            
            Text("+7 9991234567")
        }
    }
    
    private var address: some View {
        VStack(alignment: .leading) {
            Text("Адрес доставки:")
                .bold()
            
            Text("Россия, Московская область, г. Владимир, ул. Ленина д.2, кв. 10")
        }
    }
    
    private var quitButton: some View {
        Button(action: quitButtonTapped) {
            Text("Выйти")
                .font(.title3)
                .bold()
        }
        .padding(12)
        .padding(.horizontal)
        .background(Color.red)
        .foregroundColor(.white)
        .cornerRadius(20)
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
        presentationMode.wrappedValue.dismiss()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
