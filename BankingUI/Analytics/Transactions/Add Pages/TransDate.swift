//
//  TransDate.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-28.
//

import SwiftUI

struct TransDate: View {
    @Binding var showingDetail: Bool
    @EnvironmentObject var TransData: NewTransData

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Date")
                    .bold()
                    .fontWeight(.heavy)
                    .foregroundColor(.secondary)
                    .font(.system(size: 24))
                    .frame(height: 0, alignment: .leading)
                    .padding(.top, 5)
                Spacer()
            }

            Divider()
                .padding(.top, 20)

            DatePicker("", selection: $TransData.date, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 400)
                .padding(.trailing, 20)

            Spacer()
        }
        .padding(.leading, 20)

        .navigationTitle("Create a Transaction")
        .navigationBarItems(
            trailing: NavigationLink(
                destination: TransAccount(showingDetail: $showingDetail).environmentObject(TransData),
                label: {
                    Text("Next")
                }
            )
        )
    }
}

struct TransDate_Previews: PreviewProvider {
    static var previews: some View {
        var Transdata = NewTransData()

        NavigationView {
            TransDate(showingDetail: .constant(true)).environmentObject(Transdata)
        }
        .preferredColorScheme(.dark)
    }
}
