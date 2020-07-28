//
//  TabBar.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-25.
//

import SwiftUI

struct TabBar: View {
    @State private var selected = 0

    var body: some View {
        TabView(selection: $selected) {
            OverviewPage()
                .tabItem {
                    Image(systemName: selected == 0 ? "house.fill" : "house")
                    Text("Overview")
                }.tag(0)
            Analytics()
                .tabItem {
                    Image(systemName: selected == 1 ? "chart.bar.fill" : "chart.bar")
                    Text("Analytics")
                }.tag(1)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
