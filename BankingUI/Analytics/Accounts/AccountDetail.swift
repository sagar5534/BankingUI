//
//  AccountDetail.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI
import SwiftUICharts

struct AccountDetail: View {
    
    var account: Account
    var chartData: [Double] {
        return (account.transactions?.getMonthly())!
    }
    var pinkStlye = ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .prplPink)

    var body: some View {
        ScrollView {

            NavigationLink(destination: TransactionList()) {
                AddRow(name: "Add a Transaction")
            }
            
            CardView(showShadow: false){
                
                ChartLabel("MONTHLY SPENDINGS", type: ChartLabelType.custom(size: 17, padding: .init(top: 0, leading: 0, bottom: 0, trailing: 0), color: .secondary))
                Divider()
                BarChart()
                    
            }
            .data(chartData)
            .chartStyle(pinkStlye)
            .frame(height: 200)
            .padding()
            
            
            VStack {
                ElementTitle(title: "Recent Transactions") {
                    NavigationLink(destination: TransactionList()) {
                        Text("See All")
                    }
                }
                
                ForEach(0 ..< (account.transactions?.count ?? 0 < 3 ? account.transactions?.count ?? 0 : 3)) { number in
                    let trans = account.transactions![number] 
                    NavigationLink(destination: TransactionDetail(transaction: trans)) {
                        TransactionRowLimited(transaction: trans)
                    }
                    .foregroundColor(.primary)
                }
                
            }
            .padding()
        }
        .navigationTitle(account.desc ?? "")
        
    }
}

struct AccountDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountDetail(account: Account(id: 1, type: "BANK", desc: "Hi Sagar", totalValue: 99))
        }
    }
}
