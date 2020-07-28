//
//  Overview.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-27.
//

import SwiftUI

struct OverviewPage: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var data: GlobalData
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Good Evening, Sagar")
                        .bold()
                        .fontWeight(.heavy)
                        .foregroundColor(.secondary)
                        .font(.system(size: 24))
                        .frame(height: 0, alignment: .leading)
                        .padding(.top, 5)
                    Spacer()
                }
                .padding(.leading, 22)
                .padding(.bottom, 10)

                Divider()
                
                // --------------------------------------------------
                
                AccountsOverview(colorScheme: colorScheme)
                    .environmentObject(data)
                
                Spacer()
                
            }
            

            .navigationTitle("Overview")
        }
    }
}

struct OverviewPage_Previews: PreviewProvider {
    static var previews: some View {
        OverviewPage()
            .preferredColorScheme(.dark)
    }
}
