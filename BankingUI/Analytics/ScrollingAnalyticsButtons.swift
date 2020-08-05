//
//  ScrollingAnalyticsButtons.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-03.
//

import SwiftUI
import SwiftUICharts

struct ScrollingAnalyticsButtons: View {
    var body: some View {
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
                                .fill(LinearGradient(gradient: Gradient(colors: [ColorGradient.orngPink.startColor, ColorGradient.orngPink.endColor]),
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
    }
}

struct ScrollingAnalyticsButtons_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingAnalyticsButtons()
    }
}
