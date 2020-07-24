//
//  AccountList.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct AccountList: View {
    @State var isEditMode: EditMode = .inactive
    @State var showingDetail = false
    @State var accounts: AccountCollection

    var body: some View {
        List {
            AddRow(name: "Add an Account")
                .onTapGesture {
                    self.showingDetail.toggle()
                }.sheet(isPresented: $showingDetail) {
                    DetailView()
                }
            ForEach(accounts, id: \.self) { account in

                NavigationLink(destination: AccountDetail(account: account)) {
                    AccountRow(account: account)
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(PlainListStyle())

        .navigationTitle("Accounts")
        .navigationBarItems(trailing: EditButton())
        .navigationViewStyle(DefaultNavigationViewStyle())
        .environment(\.editMode, self.$isEditMode)
    }

    func delete(at offsets: IndexSet) {
        accounts.remove(atOffsets: offsets)
    }
}

struct AccountList_Previews: PreviewProvider {
    static var previews: some View {
        let accounts: AccountCollection = [
            Account(id: 1, type: "BANK", desc: "RBC Debit", totalValue: 899),
            Account(id: 2, type: "CASH", desc: "My Cash", totalValue: 40),
            Account(id: 3, type: "CREDIT", desc: "VISA", totalValue: -430),
        ]
        
        AccountList(accounts: accounts)
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail")
    }
}
