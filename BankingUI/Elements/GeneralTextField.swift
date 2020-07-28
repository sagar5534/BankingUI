//
//  Add Views.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-26.
//

import Foundation
import SwiftUI

struct GeneralTextField: View {
    @State var title: String
    @Binding var text: String

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(title)
                    .bold()
                    .fontWeight(.heavy)
                    .foregroundColor(.secondary)
                    .font(.system(size: 24))
                    .frame(height: 0, alignment: .leading)
                    .padding(.top, 5)
                Spacer()
            }

            Divider()
                .padding(.top, 20)

            TextField("type something...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .multilineTextAlignment(.leading)
                .font(.system(size: CGFloat(50), weight: Font.Weight.medium))

            Spacer()
        }
        .padding(.leading, 20)
    }
}
