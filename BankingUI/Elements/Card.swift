//
//  Card.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-29.
//

import SwiftUI

public struct Card<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme

    let content: () -> Content
    private var showShadow: Bool

    public init(showShadow: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.showShadow = showShadow
        self.content = content
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.secondarySystemGroupedBackground))
                .shadow(color: Color.gray, radius: showShadow ? 8 : 0)

            VStack {
                self.content()
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Card {
                Text("Hey")
            }
            .padding(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/, 10)
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))

            Card {
                Text("Hey")
            }
            .environment(\.colorScheme, .dark)
            .preferredColorScheme(.dark)
            .padding(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/, 10)
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
        }
    }
}
