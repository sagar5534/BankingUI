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
        VStack {
            Leading {
                Text("hey")
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                    .frame(height: 0, alignment: .leading)
            }
            .padding(.top, 10)
            .padding(.leading, 22)

            Divider()
                .padding(.top, 20)

            Leading {
                Text(transaction.amount!.toMoney())
                    .fontWeight(.heavy)
                    .font(.system(size: 70))
            }
            .padding(.leading, 22)

            Spacer()
        }

        .navigationTitle(transaction.desc ?? "")
        .navigationBarItems(trailing: EditButton())
    }
}

struct TransactionDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TransactionDetail(transaction: Transaction(id: 1, desc: "Starbucks", amount: 89))
        }
    }
}
