//
//  Analy/Volumes/Macintosh HD/Users/sagar/Projects/ChartViewtics.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import Alamofire
import SwiftUI
import SwiftUICharts

struct Analytics: View {
    @EnvironmentObject var data: GlobalData
    @State var showingNewAccount = false

    var greenStlye = ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .green)
    var pinkStlye = ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .prplPink)

    var sortedAccount: AccountCollection {
        return data.accounts.sorted { $0.type! < $1.type! }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                
                ElementTitle(title: "Accounts") {
                    Button(action: {
                        showingNewAccount.toggle()
                    }, label: {
                        Text("Add")
                    })
                }
                .padding()

                ScrollingAccountList().environmentObject(data)

                // ----------------------------------------------
                ElementTitle(title: "Manage") {}
                    .padding()

                HStack {
                    NavigationLink(destination: TransactionList(trans: data.transactions)) {
                        ManageButtons(name: "All Transactions", image: "card-white")
                    }
                    NavigationLink(destination: TagList()) {
                        ManageButtons(name: "Manage Tags", image: "tag-white")
                    }
                }
                .frame(height: 185)
                .padding(.leading, 20)
                .padding(.trailing, 20)

                // -----------------------------------------------------
                
                ElementTitle(title: "Insights") {}
                    .padding()

                HStack {
                    MiniChart(title: "Credit Spending", chartData: data.monthlySpendings, style: pinkStlye)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }

            .navigationTitle("Analytics")
            .sheet(isPresented: $showingNewAccount) {
                AccountName(showingDetail: $showingNewAccount).environmentObject(data)
            }
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
