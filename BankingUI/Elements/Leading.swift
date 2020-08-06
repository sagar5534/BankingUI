//
//  Leading.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-05.
//

import SwiftUI

public struct Leading<Content: View>: View {
    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        HStack {
            self.content()
            Spacer()
        }
    }
}
