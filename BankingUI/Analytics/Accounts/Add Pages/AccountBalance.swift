//
//  AccountBalance.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-26.
//

import SwiftUI
import Combine

struct AccountBalance: View {
    
    @Binding var showingDetail: Bool
    @EnvironmentObject var AccountData: NewAccountData

    @State private var value: Double? = 0.0
    @State private var selected = 0

    var options = ["Expense", "Income"]
    
    var body: some View {
                    
        Currency(title: "Enter current balance", options: options, value: $value, selected: $selected)
            
        .navigationTitle("Create a Account")
        .navigationBarItems(
            trailing: NavigationLink(
                destination: AccountSummary(),
                label: {
                    Text("Next")
                }
            )
        )
        
    }
    
}

struct AccountBalance_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AccountBalance(showingDetail: .constant(true))
        }
    }
}
