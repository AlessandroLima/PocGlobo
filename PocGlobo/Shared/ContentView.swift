//
//  ContentView.swift
//  Shared
//
//  Created by Alessandro Teixeira Lima on 12/01/24.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        Text("Hello, world!")
//            .padding()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


import SwiftUI

struct ContentView: View {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
//            Image("seu_logo")
//                .resizable()
//                .frame(width: 100, height: 100)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.white, lineWidth: 4))
//                .shadow(radius: 10)

            VStack(spacing: 20) {
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)

            Button(action: {
                // Implementar a lógica de login aqui
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
        }
        .padding()
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
