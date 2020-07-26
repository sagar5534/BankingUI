//
//  TransactionList.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct TransactionList: View {
    
    @EnvironmentObject var data: GlobalData

    @State var isEditMode: EditMode = .inactive

    var body: some View {
        List {
            AddRow(name: "Add a Transaction")
            ForEach(data.transactions, id: \.self) { tran in

                let acc = data.accounts.getAccount(accountId: tran.accountID!)
                NavigationLink(destination: TransactionDetail(transaction: tran)) {
                    TransactionRow(transaction: tran, account: acc)
                }
                
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
        data.deleteTransaction(id: offsets.first!)
        data.transactions.remove(atOffsets: offsets)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        let observed = GlobalData()
        
        NavigationView{
            TransactionList()
                .environmentObject(observed)
        }
        
    }
}
