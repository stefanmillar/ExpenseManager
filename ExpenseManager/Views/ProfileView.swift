//
//  ProfileView.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-27.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @Binding var user: ExpenseUser
    @Binding var isAuthenticated: Bool
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    init(user: Binding<ExpenseUser>, isAuthenticated: Binding<Bool>) {
        UITableView.appearance().backgroundColor = .clear
        self._user = user
        self._isAuthenticated = isAuthenticated
    }
    
    var body: some View {
        VStack (spacing: 0) {
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("Profile")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.purple), Color(UIColor.systemPurple)]), startPoint: .topTrailing, endPoint: .bottomTrailing))
            
            Spacer()
            
            Text(user.name)
                .font(Font.largeTitle)
            
            Text(user.email)
                .padding()
            
            Button(action: { showAlert = true }) {
                Label("Sign Out", systemImage: "iphone.homebutton.slash")
                    .padding(10)
            }
            .background(.red)
            .foregroundColor(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black, radius: 1, x: 1, y: 1)
            
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Sign Out?"),
                  message: Text(""),
                  primaryButton: .default(Text("Yes"), action: signOut),
                  secondaryButton: .destructive(Text("Cancel")) {
                        showAlert = false
                    }
            )
        }
    }
    
    /**
     Signs the current user out
     */
    func signOut() {
        try? Auth.auth().signOut()
        isAuthenticated = false
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: .constant(ExpenseUser.sample), isAuthenticated: .constant(true))
    }
}
