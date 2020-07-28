//
//  AccountBalance.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-26.
//

import Combine
import SwiftUI

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
                    destination: AccountSummary(showingDetail: $showingDetail).environmentObject(AccountData),
                    label: {
                        Text("Next")
                    }
                )
            )
            .onChange(of: value!) { val in
                AccountData.amount = val
            }
    }
}

struct AccountBalance_Previews: PreviewProvider {
    static var previews: some View {
        let AccountData: NewAccountData = NewAccountData()

        NavigationView {
            AccountBalance(showingDetail: .constant(true)).environmentObject(AccountData)
        }
    }
}
