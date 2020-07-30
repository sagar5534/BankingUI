//
//  TransMerchant.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-28.
//

import SwiftUI

struct TransMerchant: View {
    @Binding var showingDetail: Bool

    @EnvironmentObject var TransData: NewTransData
    @State private var text: String = ""

    var body: some View {
        GeneralTextField(title: "Merchant", text: $text)
            .onChange(of: text) { value in
                TransData.name = value
            }

            .navigationTitle("Create a Transaction")
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: TransDate(showingDetail: $showingDetail).environmentObject(TransData),
                    label: {
                        Text("Next")
                    }
                ).disabled(text.isEmpty)
            )
    }
}

struct TransMerchant_Previews: PreviewProvider {
    static var previews: some View {
        var Transdata = NewTransData()

        NavigationView {
            TransMerchant(showingDetail: .constant(true)).environmentObject(Transdata)
        }
    }
}
