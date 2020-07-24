//
//  Analytics.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import Alamofire
import SwiftUI

struct Analytics: View {
    @ObservedObject var observed = Observer()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Account")
                        .bold()
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                        .padding(.leading, 20)
                        .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    Spacer()
                }

                let names = ["Transactions", "Tags", "Accounts"]
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(names, id: \.self) { name in

                            NavigationLink(destination:
                                Group {
                                    if name == "Transactions" {
                                        TransactionList(transactions: observed.transactions, accounts: observed.accounts)
                                    } else if name == "Tags" {
                                        TagList(tags: observed.tags)
                                    } else {
                                        AccountList(accounts: observed.accounts)
                                    }
                                }) {
                                ZStack(alignment: .bottomLeading) {
                                    Rectangle().foregroundColor(.blue)
                                        .cornerRadius(5)
                                    Text(name).fontWeight(.black)
                                        .padding()
                                        .foregroundColor(.white)
                                }
                                .frame(width: 200, height: 200)
                            }
                        }
                    }
                }
                .padding(.leading, 20)
                Spacer()
            }

            .navigationTitle("Analytics")
        }
    }
}

struct Analytics_Previews: PreviewProvider {
    static var previews: some View {
        Analytics()
            .preferredColorScheme(.dark)
    }
}

class Observer: ObservableObject {
    @Published var tags = TagCollection()
    @Published var accounts = AccountCollection()
    @Published var transactions = TransactionCollection()

    init() {
        getTags()
        getAccounts()
        getTransactions()
    }

    func getTags() {
        let parameter = ["user": 1]
        let url = "http://lunar.local:4000/" + "get/tags"

        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: TagCollection.self) { response in

            switch response.result {
            case let .success(data):
                print(data)
                self.tags = data

            case let .failure(err):
                print(err)
            }
        }
    }

    func getAccounts() {
        let parameter = ["user": 1]
        let url = "http://lunar.local:4000/" + "get/account"

        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: AccountCollection.self) { response in

            switch response.result {
            case let .success(data):
                self.accounts = data

            case let .failure(err):
                print(err)
            }
        }
    }

    func getTransactions() {
        let parameter = ["user": 1]
        let url = "http://lunar.local:4000/" + "get/allTransactions"

        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: TransactionCollection.self) { response in

            switch response.result {
            case let .success(data):
                var x = data
                x.sort { (first, second) -> Bool in

                    let date1 = Date.shortformatter.date(from: first.date!)!
                    let date2 = Date.shortformatter.date(from: second.date!)!

                    if date1 > date2 { return true }
                    else { return false }
                }
                self.transactions = x

            case let .failure(err):
                print(err)
            }
        }
    }
}
