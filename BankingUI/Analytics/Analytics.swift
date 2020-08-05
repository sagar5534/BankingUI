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
                        .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    Spacer()
                }

                ScrollingAnalyticsButtons()
                // ----------------------------------------------------

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
