//
//  AccountType.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-26.
//

import SwiftUI

struct AccountType: View {
    @Binding var showingDetail: Bool
    @EnvironmentObject var AccountData: NewAccountData
    @State private var selected = 0

    var options = ["Debit", "Credit", "Cash"]
    var types = ["BANK", "CREDIT", "CASH"]

    var body: some View {
        VStack(spacing: 10) {
            
            Leading{
                Text("Select an account type")
                    .bold()
                    .fontWeight(.heavy)
                    .foregroundColor(.secondary)
                    .font(.system(size: 24))
                    .frame(height: 0, alignment: .leading)
            }
            .padding(.top, 5)
            .padding(.leading, 22)

            Divider()
                .padding(.top, 20)

            Picker(selection: $selected, label: Text("")) {
                ForEach(0 ..< options.count) {
                    Text(bankType[$0].name)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selected) { value in
                AccountData.type = bankType[value]
            }

            Spacer()
        }

        .navigationTitle("Create a Account")
        .navigationBarItems(
            trailing: NavigationLink(
                destination: AccountBalance(showingDetail: $showingDetail).environmentObject(AccountData),
                label: {
                    Text("Next")
                }
            )
        )
    }
}

struct AccountType_Previews: PreviewProvider {
    static var previews: some View {
        let AccountData: NewAccountData = NewAccountData()

        NavigationView {
            AccountType(showingDetail: .constant(true)).environmentObject(AccountData)
        }
    }
}
