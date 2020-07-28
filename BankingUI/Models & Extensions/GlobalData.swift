//
//  GlobalData.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-26.
//

import Alamofire
import Foundation

class GlobalData: ObservableObject {
    let host = "http://lunar.local:4000/"

    @Published var tags = TagCollection()
    @Published var accounts = AccountCollection()
    @Published var transactions = TransactionCollection()

    init() {
        print("Network: Call Made")
        getTags()
        getAccounts()
        getTransactions()
    }

    func getTags() {
        let parameter = ["user": 1]
        let url = host + "get/tags"

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
        let url = host + "get/account"

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
        let url = host + "get/allTransactions"

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

    func deleteTag(id: Int) {
        let parameter = ["tagID": tags[id].id]
        let url = host + "delete/tag"

        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).response { response in

            switch response.result {
            case .success:
                print("Deleted")
            case let .failure(err):
                print(err)
            }
        }
    }

    func deleteAccount(id: Int) {
        let parameter = ["account": accounts[id].id]
        let url = host + "delete/account"

        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).response { response in

            switch response.result {
            case .success:
                print("Deleted")
            case let .failure(err):
                print(err)
            }
        }
    }

    func deleteTransaction(id: Int) {
        let parameter = ["id": transactions[id].id]
        let url = host + "delete/transaction"

        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).response { response in

            switch response.result {
            case .success:
                print("Deleted")
            case let .failure(err):
                print(err)
            }
        }
    }
}
