//
//  CreateAccountView.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-20.
//

import SwiftUI
import Firebase

struct CreateAccountView: View {
    @State var newEmail: String = ""
    @State var newPassword: String = ""
    @State var newName: String = ""
    
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var showAlert = false
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color(UIColor.purple), Color(UIColor.white)]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            Form {
                
                Section(header: Color.clear) {
                    HStack {
                        Spacer()
                        Text("Create Account")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                
                Section {
                    TextField("Email", text: $newEmail)
                        .font(.largeTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .listRowBackground(Color.clear)
                
                Section {
                    
                    SecureField("Password", text: $newPassword)
                        .font(.largeTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
                .listRowBackground(Color.clear)
                
                Section {
                    TextField("Name", text: $newName)
                        .font(.largeTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .listRowBackground(Color.clear)
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.green)
                        .opacity(0.9)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 4)
                        .shadow(color: Color.black, radius: 1, x: 1, y: 1)
                    
                    Section {
                        HStack {
                            
                            Button(action: createAccount) {
                                Label("Create", systemImage: "person.fill")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            
                        }
                    }
                    
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
            }
            .padding()
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: newEmail, password: newPassword) { authResult, error in
            if error != nil {
                alertTitle = "Error"
                alertMessage = error?.localizedDescription ?? ""
                showAlert = true
            } else {
                
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
