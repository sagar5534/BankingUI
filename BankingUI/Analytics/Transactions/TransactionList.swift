//
//  TransactionList.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct TransactionList: View {

    var filters = ["3 Months", "6 Months", "All"]
    
    @State var trans: TransactionCollection?
    @State private var filterSelected: Int = 0
    @State var isEditMode: EditMode = .inactive
    @State var showingDetail = false

    var body: some View {
        VStack {
            Picker(selection: $filterSelected, label: Text("Account")) {
                ForEach(0 ..< filters.count) { num in
                    Text(filters[num])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            List {
                AddRow(name: "Add a Transaction")
                    .onTapGesture {
                        self.showingDetail.toggle()
                    }.sheet(isPresented: $showingDetail) {
                        //TransAmount(showingDetail: $showingDetail).environmentObject(data)
                    }

                ForEach(trans ?? [], id: \.self) { tran in
                    
                    NavigationLink(destination: TransactionDetail(transaction: tran)) {
                      TransactionRowLimited(transaction: tran)
                    }
                        
//                    let acc = data.accounts.getAccount(accountId: tran.accountID!)
//                    NavigationLink(destination: TransactionDetail(transaction: tran)) {
//                        TransactionRow(transaction: tran, account: acc)
//                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(PlainListStyle())
        }

        .navigationTitle("Transactions")
        .navigationBarItems(trailing: EditButton())
        .navigationViewStyle(DefaultNavigationViewStyle())
        .environment(\.editMode, self.$isEditMode)
    }

    func delete(at offsets: IndexSet) {
        //data.deleteTransaction(id: offsets.first!)
        trans?.remove(atOffsets: offsets)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TransactionList(trans: [Transaction(id: 1, desc: "HEY", amount: 45.3)])
        }
    }
}
