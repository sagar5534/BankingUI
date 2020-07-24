//
//  TransactionList.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct TransactionList: View {
    @State var isEditMode: EditMode = .inactive
    @State var transactions: TransactionCollection
    var accounts: AccountCollection

    var body: some View {
        List {
            AddRow(name: "Add a Transaction")
            ForEach(transactions, id: \.self) { tran in

                let acc = accounts.first { (account) -> Bool in
                    if account.id == tran.accountID { return true }
                    else { return false }
                }

                NavigationLink(destination: TransactionDetail(transaction: tran)) {
                    TransactionRow(transaction: tran, account: acc ?? Account(id: 1, type: "Error", desc: "Error", totalValue: 0))
                }
                .isDetailLink(true)
            }
            .onDelete(perform: delete)
        }
        .listStyle(PlainListStyle())

        .navigationTitle("Transactions")
        .navigationBarItems(trailing: EditButton())
        .navigationViewStyle(DefaultNavigationViewStyle())
        .environment(\.editMode, self.$isEditMode)
    }

    func delete(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        let transactions: TransactionCollection = [
            Transaction(id: 1, desc: "Starbucks", amount: 8),
            Transaction(id: 2, desc: "Tims", amount: 9.99),
        ]
        let acc = [
            Account(id: 1, type: "BANK", desc: "Debit", totalValue: 500),
            Account(id: 2, type: "CREDIT", desc: "My VISA", totalValue: 850),
        ]

        TransactionList(transactions: transactions, accounts: acc)
            .preferredColorScheme(.dark)
    }
}
