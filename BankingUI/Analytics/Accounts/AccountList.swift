//
//  AccountList.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct AccountList: View {
    
    @EnvironmentObject var data: GlobalData

    @State var isEditMode: EditMode = .inactive
    @State var showingDetail = false

    var body: some View {
        List {
            AddRow(name: "Add an Account")
                .onTapGesture {
                    self.showingDetail.toggle()
                }.sheet(isPresented: $showingDetail) {
                    DetailView()
                }
            ForEach(data.accounts, id: \.self) { account in

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
        data.deleteAccount(id: offsets.first!)
        data.accounts.remove(atOffsets: offsets)
    }
}

struct AccountList_Previews: PreviewProvider {
    static var previews: some View {
        let observed = GlobalData()

        NavigationView{
            AccountList()
                .environmentObject(observed)
        }
        
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail")
    }
}
