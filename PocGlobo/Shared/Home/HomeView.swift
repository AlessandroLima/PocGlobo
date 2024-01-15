//
//  ContentView.swift
//  Shared
//
//  Created by Alessandro Teixeira Lima on 12/01/24.
//

import SwiftUI

// Model
struct User {
    var username: String
    var password: String
}

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                TextField("Username", text: $viewModel.username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)

            Button(action: {
                viewModel.login()
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            Spacer()
            
            Button(action: {
                viewModel.addEvents()
            }) {
                Text("Adicionar Eventos")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            Spacer()
        }
        .padding()
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
