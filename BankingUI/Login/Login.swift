//
//  Login.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-04.
//

import AuthenticationServices
import SwiftUI

struct Login: View {
    var body: some View {
        ZStack {
            Image("LoginBG")
                .resizable()
                .edgesIgnoringSafeArea(.all)

            VStack {
                Leading{
                    VStack(alignment: .leading) {
                        Image(systemName: "bolt.horizontal.fill")
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 70, height: 35, alignment: .center)
                            .foregroundColor(.white)
                        Text("Banking Made\nSimple")
                            .fontWeight(.bold)
                            .font(.system(size: 45))
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 40)
                    .padding(.top, 40)
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
                        case let .success(_):
                            // 2
                            print("Authorization successful.")
                        case let .failure(error):
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
