//
//  AccountsOverview.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-28.
//

import SwiftUI

struct AccountsOverview: View {
    
    var colorScheme: ColorScheme
    @EnvironmentObject var data: GlobalData
    @State private var totals: [Double] = []
    
    
    var accountsTotals: [Double] {
        
        var total: [Double] = []
        for number in bankType{
            let filteredAccount = data.accounts.filter { $0.type == number.type }
            let totalAccount = filteredAccount.reduce(0) { $0 + $1.totalValue! }
            total.append(totalAccount)
        }
        return total

    }
    
    var body: some View {
        
        List {
            HStack {
                Text("Accounts")
                    .bold()
                    .font(.title2)

                Spacer()

                Button(action: {}, label: {
                    Image(systemName: "plus").resizable()
                        .foregroundColor(.blue)
                        .frame(width: 25, height: 25)
                })
            }.padding()
            
            HStack {
                Image(colorScheme == .light ? "chart-black" : "chart-white")
                    .frame(width: 35, height: 35)
                    .padding(.trailing, 15)
                Text("Net Worth")
                    .font(.headline)
                Spacer()
                Text(getNet().toMoney())
                    .italic()
                    .fontWeight(.thin)
                    .font(.system(size: 20))
                    .padding(.leading, 10)

            }.padding()

            ForEach(0 ..< accountsTotals.count) { number in
            
                HStack {
                    
                    Image(getImage(type: bankType[number].type))
                        .frame(width: 35, height: 35)
                        .padding(.trailing, 15)
                    Text(bankType[number].name)
                        .font(.headline)
                    Spacer()
                    Text(accountsTotals[number].toMoney() ?? "")
                        .italic()
                        .fontWeight(.thin)
                        .font(.system(size: 20))
                        .padding(.leading, 10)
                }
                .padding()
            
            }
            
        }
        
    }
    
    func getImage(type: String) -> String {
        var string = ""
        
        switch type {
        case "BANK":
           string = colorScheme == .light ? "bank-black" : "bank-white"
        case "CREDIT":
            string = colorScheme == .light ? "card-black" : "card-white"
        case "CASH":
            string = colorScheme == .light ? "piggy-black" : "piggy-white"
        default:
            string = colorScheme == .light ? "piggy-black" : "piggy-white"
        }
        
        return string
    }
    
    func getNet() -> Double {
        var total = 0.0
        for i in accountsTotals{
            total = total + i
        }
        return total
    }
    
}

struct AccountsOverview_Previews: PreviewProvider {
    static var previews: some View {
        
        Text("")
    }
}
