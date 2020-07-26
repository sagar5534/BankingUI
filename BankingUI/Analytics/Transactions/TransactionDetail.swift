//
//  TransactionDetail.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct TransactionDetail: View {
    var transaction: Transaction

    var body: some View {
        List {
            Text(transaction.amount?.toMoney() ?? "")
        }
        .navigationTitle(transaction.desc ?? "")
    }
}

struct TransactionDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TransactionDetail(transaction: Transaction(id: 1, desc: "Starbucks", amount: 89))
        }
    }
}
