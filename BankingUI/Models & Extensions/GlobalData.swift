//
//  GlobalData.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-26.
//

import Alamofire
import Foundation

class GlobalData: ObservableObject {
    //let host = "http://lunar.local:4000/"
    
    let host = "https://banking.sagarpatel.ml/"
    
    @Published var tags = TagCollection()
    @Published var accounts = AccountCollection()
    @Published var transactions = TransactionCollection() {
        didSet {
            monthlySpendings = getMonthly()
            weeklySpendings = getWeekly()
        }
    }

    @Published var monthlySpendings = [Double]()
    @Published var weeklySpendings = [Double]()

    init() {
        print("Network: Call Made")
        getTags()
        getAccounts()
        getTransactions()
    }

    func getWeekly() -> [Double] {
        var total: [Double] = []

        let today = Date()
        let start = today.startOfWeek!

        for i in 0 ... 6 {
            let cursor = Calendar.current.date(byAdding: .day, value: i, to: start)

            let trans = transactions.filter { $0.toShortDate().isInSameDay(as: cursor!) }
            let tot = trans.reduce(0) { $0 + ($1.amount! > 0 ? $1.amount! : 0) }
            total.append(tot)
        }

        return total
    }

    func getMonthly() -> [Double] {
        var total: [Double] = []
        let creditAccounts = accounts.filterFor(type: bankType[1])

        var combinedTrans: TransactionCollection = []
        for acc in creditAccounts {
            combinedTrans += transactions.filterByAccount(id: acc.id!)
        }

        for i in 1 ... 7 {
            let previousMonth = Calendar.current.date(byAdding: .month, value: -1 * i, to: Date())
            let x = combinedTrans.filter { $0.toShortDate().isInSameMonth(as: previousMonth!) }

            let tot = x.reduce(0) { $0 + ($1.amount! > 0 ? $1.amount! : 0) }
            total.insert(tot, at: 0)
        }
        return total
    }

    func getTags() {
        let parameter = ["user": 1]
        let url = host + "get/tags"

        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: TagCollection.self) { response in

            switch response.result {
            case let .success(data):
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
                self.transactions = data.sorted(by: { $0.toShortDate() > $1.toShortDate() })
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
