//
//  TransactionRow.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct TransactionRow: View {
    
    var transaction: Transaction
    var account: Account
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.desc ?? "")
                    .fontWeight(.semibold)
                    .font(.system(size: 18))
                    .lineLimit(1)

                HStack(alignment: .center) {
                    Text(transaction.date ?? "")
                        .font(.system(size: 13))
                        .fontWeight(.light)
                    Divider()
                    Text(account.desc ?? "")
                        .font(.system(size: 13))
                        .fontWeight(.light)
                    Spacer()
                    Text(transaction.amount?.toMoney() ?? "")
                        .italic()
                        .fontWeight(.thin)
                        .font(.system(size: 20))
                        .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .padding()
    }
}

struct TransactionRow_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let trans = Transaction(desc: "Starbucks", amount: 15.99)
        let account = Account(type: "BANK", desc: "My Visa", totalValue: 0)
        
        TransactionRow(transaction: trans, account: account)
            .previewLayout(.fixed(width: 400, height: 90
            ))
    }
}
