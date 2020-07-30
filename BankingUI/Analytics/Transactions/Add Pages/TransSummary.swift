//
//  TransSummary.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-28.
//

import Alamofire
import SwiftUI

struct TransSummary: View {
    @EnvironmentObject var data: GlobalData

    @Binding var showingDetail: Bool
    @EnvironmentObject var TransData: NewTransData
    @State private var enableLogging = false
    @State private var showingAlert = false

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Summary")
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
                .padding(.bottom, 10)

            Text(TransData.amount.toMoney())
                .fontWeight(.heavy)
                .font(.system(size: 70))
                .padding()
                .padding(.trailing, 20)

            Form {
                Section(header: Text("Merchant").italic()) {
                    Text(TransData.name)
                }

                Section(header: Text("Info").italic()) {
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(TransData.date.formatted)
                    }

                    HStack {
                        Text("Account")
                        Spacer()
                        Text(TransData.account?.desc ?? "Error")
                    }
                }
            }
            .padding(.trailing, 20)

            Spacer()
        }
        .padding(.leading, 20)

        .navigationTitle("Create a Transaction")
        .navigationBarItems(
            trailing: Button(action: {
                createCall(trans: TransData)
            }, label: {
                Text("Done")
            })
        )
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Sorry!"),
                message: Text("An Error Occured"),
                primaryButton: .default(Text("Try Again"), action: {
                    createCall(trans: TransData)
                }),
                secondaryButton: .cancel {
                    self.showingDetail.toggle()
                }
            )
        }
    }

    func createCall(trans: NewTransData) {
        let url = data.host + "create/transaction"

        let parameter = [
            "amount": trans.amount,
            "accountId": trans.account!.id!,
            "desc": trans.name,
            "date": trans.date.formatted,
        ] as [String: Any]

        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: Transaction.self) { response in

            switch response.result {
            case let .success(trans):
                data.transactions.append(trans)
                self.showingDetail.toggle()
            case .failure:
                showingAlert.toggle()
            }
        }
    }
}

struct TransSummary_Previews: PreviewProvider {
    static var previews: some View {
        var Transdata = NewTransData()
        var data = GlobalData()

        NavigationView {
            TransSummary(showingDetail: .constant(true))
                .preferredColorScheme(.dark)
                .environmentObject(Transdata)
                .environmentObject(data)
        }
    }
}
