//
//  WeeklySpending.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-01.
//

import SwiftUI
import SwiftUICharts

struct MiniChart: View {
    
    var title: String
    var chartData: [Double]
    var style: ChartStyle

    var body: some View {
        
        CardView(showShadow: false) {
            ChartLabel(title, type: .subTitle)
                .padding(.top, 10)
                .padding(.leading, 10)
            BarChart()
                .padding(.leading, 10)
                .padding(.trailing, 10)
        }
        .data(chartData)
        .chartStyle(style)
        .frame(height: 200)
        
    }
}

struct MiniChart_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            MiniChart(title: "Weekly Spending", chartData: [56, 45, 23, 33], style: ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .green))
            
            MiniChart(title: "Weekly Spending", chartData: [56, 45, 23, 33], style: ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .green))
        }
    }
}
