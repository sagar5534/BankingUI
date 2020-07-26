//
//  BankingUIApp.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

@main
struct BankingUIApp: App {
    
    @ObservedObject var observed = GlobalData()

    var body: some Scene {
        WindowGroup {
            TabBar().environmentObject(observed)
        }
    }
    
}


struct BankingUIApp_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
