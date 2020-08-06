//
//  TransactionAmount.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-28.
//

import SwiftUI

class NewTransData: ObservableObject {
    @Published var amount = 0.0
    @Published var name = ""
    @Published var date = Date()
    @Published var account: Account? = nil
}

struct TransAmount: View {
    @Binding var showingDetail: Bool
    @State private var TransData = NewTransData()
    @State private var value: Double? = 0.0
    @State private var selected = 0

    var options = ["Expense", "Income"]

    var body: some View {
        NavigationView {
            Currency(title: "Enter Amount", options: options, value: $value, selected: $selected)

                .navigationTitle("Create a Transaction")
                .navigationBarItems(
                    leading: Button("Cancel") {
                        self.showingDetail.toggle()
                    }, trailing: NavigationLink(
                        destination: TransMerchant(showingDetail: $showingDetail).environmentObject(TransData),
                        label: {
                            Text("Next")
                        }
                    ).disabled(value == 0)
                )
                .onChange(of: value!) { val in
                    TransData.amount = val
                }
        }
    }
}

struct TransAmount_Previews: PreviewProvider {
    static var previews: some View {
        TransAmount(showingDetail: .constant(true))
    }
}
