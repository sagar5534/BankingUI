//
//  TransAccount.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-28.
//

import SwiftUI

struct TransAccount: View {
    @Binding var showingDetail: Bool
    @EnvironmentObject var TransData: NewTransData
    @EnvironmentObject var data: GlobalData
    @State private var selected = 0
    @State private var selected2 = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Select an account")
                    .bold()
                    .fontWeight(.heavy)
                    .foregroundColor(.secondary)
                    .font(.system(size: 24))
                    .frame(height: 0, alignment: .leading)
                    .padding(.top, 5)
                Spacer()
            }
            .padding(.leading, 20)

            Divider()
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding(.leading, 20)

            Picker("Account", selection: $selected) {
                ForEach(0 ..< bankType.count) { number in
                    Text(bankType[number].name)
                }
            }
            .padding(.trailing, 20)
            .padding(.leading, 20)
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selected) { _ in
                selected2 = 0
            }

            Form {
                Section {
                    Picker(selection: $selected2, label: Text("Account")) {
                        let x = data.accounts.filter { $0.type == bankType[selected].type }

                        ForEach(0 ..< x.count) { num in
                            Text(String(describing: x[num].desc ?? "Error")).tag(x[num].id)
                        }
                    }
                    .id(selected)
                    .pickerStyle(DefaultPickerStyle())
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                }
            }
            .onChange(of: selected2) { _ in
                let x = data.accounts.filter { $0.type == bankType[selected].type }
                TransData.account = x[selected2]
            }

            Spacer()
        }

        .navigationTitle("Create a Transaction")
        .navigationBarItems(
            trailing: NavigationLink(
                destination: TransSummary(showingDetail: $showingDetail).environmentObject(TransData),
                label: {
                    Text("Next")
                }
            )
        )
    }
}

struct TransAccount_Previews: PreviewProvider {
    static var previews: some View {
        var Transdata = NewTransData()
        var data = GlobalData()

        NavigationView {
            TransAccount(showingDetail: .constant(true))
                .environmentObject(Transdata)
                .environmentObject(data)
        }
        .preferredColorScheme(.dark)
    }
}
