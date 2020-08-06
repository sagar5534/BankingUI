//
//  ScrollingAccountList.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-06.
//

import SwiftUI

struct ScrollingAccountList: View {
    @State var accounts: AccountCollection

    var netValue: Double {
        return accounts.reduce(0) { $0 + ($1.totalValue ?? 0) }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                let netAcc = Account(id: 0, type: "NET", desc: "All Cards", totalValue: netValue)

                AccountCard(account: netAcc, color: 0)
                    .frame(width: 140, height: 250)

                ForEach(accounts.indices, id: \.self) { acc in
                    AccountCard(account: accounts[acc], color: acc + 1)
                        .frame(width: 140, height: 250)
                }
            }
        }
    }
}

struct ScrollingAccountList_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingAccountList(accounts: [])
    }
}
