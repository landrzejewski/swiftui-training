//
//  ProfieView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 01/06/2023.
//

import SwiftUI
import Factory

struct ProfieView: View {
    
    @ObservedObject
    var viewModel: ProfileViewModel
    @State
    var profileImage: UIImage?
    @State
    var showImagePicker = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if profileImage != nil {
                        Image(uiImage: profileImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                    } else {
                        Image("Placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                    }
                }
                .onTapGesture { showImagePicker.toggle() }
                Form {
                    Section(header: Text("Personal info")) {
                        TextField("first-name", text: $viewModel.firstName)
                        TextField(LocalizedStringKey("last-name"), text: $viewModel.lastName)
                        TextField("Email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        SecureField("Password", text: $viewModel.password)
                        DatePicker("Date of birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                        Toggle("Subscriber", isOn: $viewModel.isSubscriber)
                    }
                    if !viewModel.errors.isEmpty {
                        ForEach(viewModel.errors, id: \.self) {
                            Text($0).foregroundColor(.red)
                        }
                    }
                    if viewModel.isSubscriber {
                        Section(header: Text("Card info")) {
                            TextField("Card number", text: $viewModel.cardNumber)
                            TextField("CVV", text: $viewModel.cardCvv)
                            DatePicker("Expiration date", selection: $viewModel.cardExpirationDate, displayedComponents: .date)
                        }
                    }
                }
                Button(action: {}) {
                    Text("Save")
                        .frame(width: 200, height: 40)
                        .foregroundColor(.white)
                        .background(Color.mainColor)
                }
                .cornerRadius(8)
                Spacer()
            }
            .navigationTitle("Profile")
            //.navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(selectedImage: $profileImage, source: .photoLibrary)
            }
        }
    }
}

struct ProfieView_Previews: PreviewProvider {
    static var previews: some View {
        ProfieView(viewModel: Container.shared.profileViewModel())
    }
}
