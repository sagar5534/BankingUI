//
//  Analytics.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import Alamofire
import SwiftUI
import SwiftUICharts

struct Analytics: View {
    @EnvironmentObject var data: GlobalData
    
    var netValue: Double {
        var total = 0.0
        for i in data.accounts {
            total = total + i.totalValue!
        }
        return total
    }

    var greenStlye = ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .green)
    var pinkStlye = ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .prplPink)

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Account")
                        .bold()
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                        .padding(.leading, 20)
                        .padding(.top, 10)
                    Spacer()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        
                        ScrollingAccounts(account: Account(id: 0, type: "NET", desc: "All Cards", totalValue: netValue), color: 0)
                            .frame(width: 140, height: 250)
                        
                        ForEach(data.accounts.indices, id: \.self) { acc in
                            ScrollingAccounts(account: data.accounts[acc], color: acc + 1)
                                .frame(width: 140, height: 250)
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.bottom, 10)
                            
                HStack {
                    Text("Insights")
                        .bold()
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                        .padding(.leading, 20)
                        .padding(.top, 10)
                    Spacer()
                }

                HStack {
                    MiniChart(title: "Weekly Spending", chartData: data.weeklySpendings, style: greenStlye)

                    MiniChart(title: "Credit Spending", chartData: data.monthlySpendings, style: pinkStlye)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)

                Spacer()
            }

            .navigationTitle("Analytics")
        }
    }
    
    
}

struct Analytics_Previews: PreviewProvider {
    static var previews: some View {
        let observed = GlobalData()

        Analytics()
            .environmentObject(observed)
    }
}
