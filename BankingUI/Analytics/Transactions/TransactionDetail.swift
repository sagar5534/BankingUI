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
            HStack {
                Text(transaction.toShortDateString())
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                    .frame(height: 0, alignment: .leading)
                Spacer()
            }
            .padding(.leading, 22)
            .padding(.top, 5)
            .padding(.bottom, 10)

            Divider()
                .padding(.leading, 20)
                .padding(.trailing, 20)

            // Value
            HStack {
                Text(transaction.amount!.toMoney())
                    .fontWeight(.heavy)
                    .font(.system(size: 70))
                    .padding(.leading, 20)

                Spacer()
            }

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
