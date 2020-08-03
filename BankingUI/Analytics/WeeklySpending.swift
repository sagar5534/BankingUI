//
//  WeeklySpending.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-01.
//

import SwiftUI
import SwiftUICharts

struct WeeklySpending: View {
    
    var title: String
    var chartData: [Double]
    var blueStlye = ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .green)

    var body: some View {
        
        CardView(showShadow: false) {
            VStack {
                ChartLabel(title, type: .subTitle)
            }
            .padding(.top, 10)
            .padding(.leading, 10)


            BarChart()
                .padding(.leading, 10)
                .padding(.trailing, 10)
        }
        .data(chartData)
        .chartStyle(blueStlye)
        .frame(height: 200)
        
    }
}

struct WeeklySpending_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            WeeklySpending(title: "Weekly Spending", chartData: [56, 45, 23, 33])
            WeeklySpending(title: "Weekly Spending", chartData: [56, 45, 23, 33])
        }
    }
}
