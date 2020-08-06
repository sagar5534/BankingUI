//
//  Add Account Name.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-26.
//

import SwiftUI

class NewAccountData: ObservableObject {
    @Published var name = ""
    @Published var amount = 0.0
    @Published var type: BankType?
}

struct AccountName: View {
    @Binding var showingDetail: Bool
    @State private var showingAlert = false
    @State private var AccountData = NewAccountData()
    @State private var text: String = ""

    var body: some View {
        NavigationView {
            GeneralTextField(title: "Name your new Account", text: $text)
                .onChange(of: text) { value in
                    AccountData.name = value
                }

                .navigationTitle("Create a Account")
                .navigationBarItems(
                    leading: Button("Cancel") {
                        self.showingDetail.toggle()
                    }, trailing: NavigationLink(
                        destination: AccountType(showingDetail: $showingDetail).environmentObject(AccountData),
                        label: {
                            Text("Next")
                        }
                    ).disabled(text.isEmpty)
                )
        }
    }
}

struct AccountName_Preview: PreviewProvider {
    static var previews: some View {
        AccountName(showingDetail: .constant(true))
    }
}
