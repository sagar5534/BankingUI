//
//  AccountRow.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct AccountRow: View {

    var account: Account
    
    var body: some View {
        HStack {
            Text(account.desc ?? "")
                .fontWeight(.semibold)
            Spacer()
            Text(account.totalValue?.toMoney() ?? "$0.00")
                .italic()
                .fontWeight(.thin)
                .font(.system(size: 20))
        }
        .padding()
    }
}


struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        let account = Account(type: "BANK", desc: "My Visa", totalValue: 0)
        AccountRow(account: account)
            .previewLayout(.sizeThatFits)
    }
}
