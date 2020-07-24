//
//  TransactionList.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct TransactionList: View {
    
    @State var isEditMode: EditMode = .inactive
    @State private var transactions: TransactionCollection = [
        Transaction(id: 1, desc: "Starbucks", amount: 8),
        Transaction(id: 2, desc: "Tims", amount: 9.99)
    ]

    var body: some View {
        
        List{
            AddRow(name: "Add a Transaction")
            ForEach(transactions, id: \.self) { tran in
                
                NavigationLink(destination: TransactionDetail(transaction: tran)) {
                    TransactionRow(transaction: tran, account: Account(type: "", desc: "My Credit Card", totalValue: 9))
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
        TransactionList()
            .preferredColorScheme(.dark)
    }
}
