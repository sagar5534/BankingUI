//
//  Login.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-04.
//

import SwiftUI
import AuthenticationServices



struct Login: View {
    var body: some View {
        
        ZStack {
            
            Image("LoginBG")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                
                HStack {
                    VStack(alignment: .leading) {
                            Image("Human")
                                .resizable()
                                .background(Color.white)
                                .cornerRadius(10)
                                .frame(width: 69, height: 69, alignment: .leading)
                            Text("Banking Made")
                                .fontWeight(.bold)
                                .font(.system(size: 45))
                                .foregroundColor(.white)
                            Text("Simple")
                                .fontWeight(.bold)
                                .font(.system(size: 45))
                                .foregroundColor(.white)
                                

                    }
                    .padding(.leading, 40)
                    .padding(.top, 40)
                    Spacer()
                }
                
                
                   
                

                
                Spacer()
                
                
                SignInWithAppleButton(
                    .signIn,
                    onRequest: { request in
                        // 1
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        switch result {
                        case .success (let authResults):
                            // 2
                            print("Authorization successful.")
                        case .failure (let error):
                            // 3
                            print("Authorization failed: " + error.localizedDescription)
                        }
                    }
                )
                .frame(height: 55)
                .signInWithAppleButtonStyle(.white)
                .cornerRadius(100)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.bottom, 40)
                
                
                
            }
            
            
        }
        
            
    }
}


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
