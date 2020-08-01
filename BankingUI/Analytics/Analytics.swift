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
