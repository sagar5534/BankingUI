//
//  Overview.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-27.
//

import SwiftUI
import SwiftUICharts

struct OverviewPage: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var data: GlobalData
    @State var chartData: [Double] = [4, 5, 6, 2, 13, 4, 3, 6]

    var blueStlye = ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .orangeBright)

    let mixedColorStyle = ChartStyle(backgroundColor: Color(UIColor.secondarySystemGroupedBackground), foregroundColor: [
        ColorGradient(ChartColors.orangeBright, ChartColors.orangeDark),
        ColorGradient(.purple, .blue),
    ])

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Good Evening, Sagar")
                        .bold()
                        .fontWeight(.heavy)
                        .foregroundColor(.secondary)
                        .font(.system(size: 24))
                        .frame(height: 0, alignment: .leading)
                        .padding(.top, 5)
                    Spacer()
                }
                .padding(.leading, 22)
                .padding(.bottom, 10)
                Divider()

                // --------------------------------------------------

                ScrollView {
                    VStack(spacing: 20) {
                        Card(showShadow: colorScheme == .light) {
                            HStack {
                                Text("Accounts")
                                    .bold()
                                    .font(.title)
                                    .font(.system(size: 32))
                                    .padding(EdgeInsets(top: 16.0, leading: 8.0, bottom: 0.0, trailing: 8.0))

                                Spacer()
                            }
                            .padding(.top, 15)
                            .padding(.leading, 15)

                            Divider()

                            AccountsOverview(colorScheme: colorScheme)
                                .environmentObject(data)
                                .padding()
                        }

                        CardView(showShadow: colorScheme == .light) {
                            VStack {
                                ChartLabel("Monthly", type: .title)
                                Text("Credit Card Spendings")
                                    .font(.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                            }
                            .padding(.top, 15)
                            .padding(.leading, 15)

                            Divider()

                            LineChart()
                        }
                        .data(chartData)
                        .chartStyle(blueStlye)
                        .frame(height: 300)

                    }.padding(.all, 22)
                }

                Spacer()
            }

            .navigationTitle("Overview")
        }
    }
}

struct OverviewPage_Previews: PreviewProvider {
    static var previews: some View {
        var data = GlobalData()

        var chartData: [Double] = [4, 5, 6, 2, 13, 4, 3, 6]
        var blueStlye = ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .orangeBright)

        Group {
            OverviewPage()
                .preferredColorScheme(.dark)
                .environmentObject(data)
        }
    }
}
