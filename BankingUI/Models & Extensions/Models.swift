
import Foundation
import Alamofire

// MARK: - AccountOverview

struct AccountOverview: Codable {
    var overview: Overview?
    var account: AccountCollection?

    func findById(search: Int) -> Account {
        for i in account! {
            if i.id == search {
                return i
            }
        }
        return Account()
    }
}

// MARK: - Account

struct Account: Codable, Identifiable, Hashable {
    let id, userID: Int?
    var type, desc: String?
    var totalValue: Double?
    let status, createdAt, updatedAt: String?
    let transactions: [Transaction]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case type, desc
        case totalValue = "total_value"
        case status, createdAt, updatedAt, transactions
    }

    init() {
        id = nil
        userID = nil
        desc = nil
        type = nil
        totalValue = nil
        status = nil
        transactions = nil
        createdAt = nil
        updatedAt = nil
    }

    internal init(id: Int? = nil, type: String? = nil, desc: String? = nil, totalValue: Double? = nil) {
        self.id = id
        userID = 1
        self.type = type
        self.desc = desc
        self.totalValue = totalValue
        status = "ACTIVE"
        createdAt = ""
        updatedAt = ""
        transactions = []
    }
}

typealias AccountCollection = [Account]

extension AccountCollection {
    
    func getAccount(accountId: Int) -> Account {
        let acc = self.first { (account) -> Bool in
            if account.id == accountId { return true }
            else { return false }
        }
        return acc ?? Account(id: 1, type: "Error", desc: "Error", totalValue: 0)
    }
}

// MARK: - Transaction
struct Transaction: Codable, Identifiable, Hashable {
    var id, accountID: Int?
    var desc, date: String?
    var amount: Double?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case accountID = "account_id"
        case desc, date, amount, createdAt, updatedAt
    }

    init() {
        id = nil
        accountID = nil
        desc = ""
        date = ""
        amount = 0.0
        createdAt = ""
        updatedAt = ""
    }

    internal init(id: Int? = nil, desc: String? = nil, amount: Double? = nil) {
        self.id = id
        accountID = 1
        self.desc = desc
        date = "July 30 2020"
        self.amount = amount
        createdAt = nil
        updatedAt = nil
    }

    func toDate() -> Date {
        return Date.formatter.date(from: date!)!
    }

    func toDateString() -> String {
        return toDate().formatted
    }
}

typealias TransactionCollection = [Transaction]

// MARK: - Overview

struct Overview: Codable {
    var bank, credit, cash: Double?
    let netWorth: Double?

    enum CodingKeys: String, CodingKey {
        case bank, credit, cash
        case netWorth = "net_worth"
    }
}

struct Error {
    var name: String
    var image: String
}

typealias MonthlySpending = [String: Double]

// MARK: - TagElement

struct Tag: Codable, Identifiable, Hashable {
    let id, userID: Int?
    let name, color, status, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case name, color, status, createdAt, updatedAt
    }

    internal init(id: Int?, name: String?, color: String?) {
        self.id = id
        userID = nil
        self.name = name
        self.color = color
        status = nil
        createdAt = nil
        updatedAt = nil
    }
}

typealias TagCollection = [Tag]

// Only used locally
struct BankType {
    var name: String
    var type: String

    init(name: String, type: String) {
        self.name = name
        self.type = type
    }
}
