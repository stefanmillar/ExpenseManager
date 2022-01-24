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
    
    @Binding var rootActive: Bool
    
    init(rootActive: Binding<Bool>) {
        UITableView.appearance().backgroundColor = .clear
        self._rootActive = rootActive
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
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    rootActive = false
                }
            )
        }
        
    }
    
    func createAccount() {
        let firebase = FirebaseDB()
        
        // Create user is authentication storage
        Auth.auth().createUser(withEmail: newEmail, password: newPassword) { authResult, error in
            if error != nil {
                alertTitle = "Error"
                alertMessage = error?.localizedDescription ?? ""
                showAlert = true
                
            // Create user in firestore
            } else if !firebase.createUser(email: newEmail, name: newName, userID: authResult?.user.uid ?? "err") {
                    alertTitle = "Error"
                    alertMessage = "Error adding user to firestore"
                    showAlert = true
            } else {
                alertTitle = "Success"
                alertMessage = "User created"
                showAlert = true
                
                print("User \(authResult?.user.uid ?? "") created")
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView(rootActive: .constant(false))
    }
}
