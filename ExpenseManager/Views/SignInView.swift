//
//  SignInView.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-18.
//

import SwiftUI
import Firebase

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isSignedIn = false
    @State var isActive = false
    
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var showAlert = false
    
    @Binding var isAuthenticated: Bool
    
    init(isAuthenticated: Binding<Bool>) {
        UITableView.appearance().backgroundColor = .clear
        self._isAuthenticated = isAuthenticated
    }
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color(UIColor.purple), Color(UIColor.white)]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            Form {
                
                Section(header: Color.clear) {
                    HStack {
                        Spacer()
                        Text("Log In")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                
                Section {
                    TextField("Email", text: $email)
                        .font(.largeTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .listRowBackground(Color.clear)
                
                Section {
                    VStack {
                        SecureField("Password", text: $password)
                            .font(.largeTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        NavigationLink(destination: CreateAccountView(rootActive: $isActive), isActive: $isActive) {
                            Text("Create Account")
                                .foregroundColor(.blue)
                        }
                        .padding(.top, 10)
                    }
                }
                .listRowBackground(Color.clear)
                
                Section {
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.green)
                        .opacity(0.9)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 4)
                        .shadow(color: Color.black, radius: 1, x: 1, y: 1)
                    
                    Section {
                        HStack {
                            
                            Button(action: signIn) {
                                Label("Sign In", systemImage: "iphone.and.arrow.forward")
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
    
    /**
     Signs the user in using firebase authentication
     */
    func signIn() {
        
        // Sign the user in by calling firebase auth
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            // If not successful, show alert message
            if error != nil {
                alertTitle = "Invalid"
                alertMessage = error?.localizedDescription ?? ""
                showAlert = true
            } else {
                isAuthenticated = true
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isAuthenticated: .constant(false))
    }
}
