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

// ViewModel
class HomeViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    let manager = DBConstants.sqliteManager
    let db = DBConstants.db
    lazy var event: Event = { return Event() }()
    
    init() {
        
        if let db = db {
            event.setManagerAndDB(manager: manager, db: db)
        }
    
    }

    func login() {
        print("Login Button Pressed")
        print("Username: \(username)")
        print("Password: \(password)")
        
        let eventToInsert = [
            Event(type: "\(TypesOfEvents.onclick)", createdIn: "\(NSDate().timeIntervalSince1970)")
        ]
        
        _ = event.insertEventInBatch(events: eventToInsert)
        
    }
}

// View
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack {
//            Image("seu_logo")
//                .resizable()
//                .frame(width: 100, height: 100)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.white, lineWidth: 4))
//                .shadow(radius: 10)

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


//struct HomeView: View {
//
//    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
//
//    @State private var username: String = ""
//    @State private var password: String = ""
//
//    var body: some View {
//        VStack {
////            Image("seu_logo")
////                .resizable()
////                .frame(width: 100, height: 100)
////                .clipShape(Circle())
////                .overlay(Circle().stroke(Color.white, lineWidth: 4))
////                .shadow(radius: 10)
//
//            VStack(spacing: 20) {
//                TextField("Username", text: $username)
//                    .padding()
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(10)
//
//                SecureField("Password", text: $password)
//                    .padding()
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(10)
//            }
//            .padding(.horizontal, 40)
//
//            Button(action: {
//                // Implementar a lógica de login aqui
//            }) {
//                Text("Login")
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(width: 200, height: 50)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            .padding(.top, 20)
//
//            Spacer()
//        }
//        .padding()
//        .background(Color.white.edgesIgnoringSafeArea(.all))
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//                HomeView()
//    }
//}
