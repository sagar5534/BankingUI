//
//  TagRow.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct TagRow: View {

    var name: String
    var color: Color

    var body: some View {
        HStack {
            Image(systemName: "circle.fill").resizable()
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 3))
                .shadow(radius: 3)
                .frame(width: 40, height: 25)
                .foregroundColor(color)
                .padding(.trailing, 4)
            Text(name)
            Spacer()
        }
        .padding()
    }
}

struct TagRow_Previews: PreviewProvider {
    static var previews: some View {
        TagRow(name: "Shopping", color: .pink)
            .previewLayout(.sizeThatFits)
    }
}



