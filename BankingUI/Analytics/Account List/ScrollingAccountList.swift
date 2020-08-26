//
//  ScrollingAccountList.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-06.
//

import SwiftUI

struct ScrollingAccountList: View {
    //@State var accounts: AccountCollection
    
    @EnvironmentObject var data: GlobalData
    
    var netValue: Double {
        return data.accounts.reduce(0) { $0 + ($1.totalValue ?? 0) }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                let netAcc = Account(id: 0, type: "NET", desc: "All Cards", totalValue: netValue)

                AccountCard(account: netAcc, color: 0)
                    .frame(width: 140, height: 250)
                    .foregroundColor(.primary)

                ForEach(data.accounts.indices, id: \.self) { acc in

                    NavigationLink(destination: AccountDetail(account: data.accounts[acc])) {
                        AccountCard(account: data.accounts[acc], color: acc + 1)
                            .frame(width: 140, height: 250)
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
    }
}

struct ScrollingAccountList_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingAccountList()
    }
}
