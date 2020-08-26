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


    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                   
                }
            }

            .navigationTitle("👋🏻 Hello Sagar")
            .navigationBarItems(trailing:
                NavigationLink(
                    destination: Settings(),
                    label: {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                )
            )
        }
    }
}

struct OverviewPage_Previews: PreviewProvider {
    static var previews: some View {
        let data = GlobalData()
        OverviewPage()
            .preferredColorScheme(.dark)
            .environmentObject(data)
    }
}
