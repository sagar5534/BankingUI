//
//  AccountSummary.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-26.
//

import Alamofire
import SwiftUI

struct AccountSummary: View {
    @EnvironmentObject var data: GlobalData

    @Binding var showingDetail: Bool
    @EnvironmentObject var AccountData: NewAccountData
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

            Form {
                Section(header: Text("Name").italic()) {
                    Text(AccountData.name)
                }

                Section(header: Text("Info").italic()) {
                    HStack {
                        Text("Type")
                        Spacer()
                        Text(AccountData.type?.name ?? "Error")
                    }

                    HStack {
                        Text("Balance")
                        Spacer()
                        Text(AccountData.amount.toMoney())
                            .italic()
                            .fontWeight(.thin)
                            .font(.system(size: 20))
                    }
                }
            }
            .padding(.trailing, 20)

            Spacer()
        }
        .padding(.leading, 20)

        .navigationTitle("Create a Account")
        .navigationBarItems(
            trailing: Button(action: {
                createCall(account: AccountData)
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
                    createCall(account: AccountData)
                }),
                secondaryButton: .cancel {
                    self.showingDetail.toggle()
                }
            )
        }
    }

    func createCall(account: NewAccountData) {
        let url = data.host + "create/account"

        let parameter = [
            "amount": account.amount,
            "user": 1,
            "desc": account.name,
            "type": account.type!.type,
        ] as [String: Any]

        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: Account.self) { response in

            switch response.result {
            case let .success(acc):
                data.accounts.append(acc)
                self.showingDetail.toggle()
            case let .failure:
                showingAlert.toggle()
            }
        }
    }
}

struct AccountSummary_Previews: PreviewProvider {
    static var previews: some View {
        let AccountData = NewAccountData()

        NavigationView {
            AccountSummary(showingDetail: .constant(true)).environmentObject(AccountData)
        }
    }
}
