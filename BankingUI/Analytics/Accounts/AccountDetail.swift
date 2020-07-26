//
//  AccountDetail.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct AccountDetail: View {
    var account: Account

    var body: some View {
        List {
            Text(account.totalValue?.toMoney() ?? "")
        }
        .navigationTitle(account.desc ?? "")
    }
}

struct AccountDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AccountDetail(account: Account(id: 1, type: "BANK", desc: "VISA", totalValue: 78))
        }
    }
}
