//
//  ElementTitle.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-25.
//

import SwiftUI

public struct ElementTitle<Content: View>: View {
    let title: String
    let trailing: () -> Content

    public init(title: String ,@ViewBuilder trailing: @escaping () -> Content) {
        self.title = title
        self.trailing = trailing
    }

    public var body: some View {
        VStack{
            HStack {
                Text(title)
                    .bold()
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                Spacer()
                trailing()
            }
            Divider()
        }
    }
    
}

struct ElementTitle_Previews: PreviewProvider {
    static var previews: some View {
        ElementTitle(title: "Testing") {
            NavigationLink(destination: TransactionList()) {
                Text("See All")
            }
        }
    }
}
