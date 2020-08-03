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
    @State var chartData: [Double] = [4, 5, 6, 2, 13, 4, 3, 6]
    
    var blueStlye = ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .prplPink)

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
                                        TransactionList()
                                    } else if name == "Tags" {
                                        TagList()
                                    } else {
                                        AccountList()
                                    }
                                }) {
                                ZStack(alignment: .bottomLeading) {
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient(colors: [ColorGradient.orngPink.startColor,ColorGradient.orngPink.endColor]),
                                                             startPoint: .bottom,
                                                             endPoint: .top))
                                        
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
                .padding(.bottom, 10)
                
                //----------------------------------------------------
                
                HStack {
                    Text("Insights")
                        .bold()
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                        .padding(.leading, 20)
                        .padding(.top, 10)
                    Spacer()
                }
                
                HStack{
                    WeeklySpending(title: "Weekly Spending", chartData: data.weeklySpendings)
                    WeeklySpending(title: "Weekly Spending", chartData: [56, 45, 23, 33, 8, 76, 29])
                    
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
