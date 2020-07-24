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
            BorderedCircle(color: color)
                .padding(.trailing, 4)
                .frame(width: 40, height: 25)
            Text(name)
            Spacer()
        }
        .padding()
    }
}

struct BorderedCircle: View {
    
    @State var color: Color
    
    var body: some View {
        Image(systemName: "circle.fill").resizable()
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 3))
            .shadow(radius: 3)
            .foregroundColor(color)
    }
}

struct TagRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TagRow(name: "Shopping", color: .pink)
                .previewLayout(.sizeThatFits)
            BorderedCircle(color: .pink)
                .previewLayout(.sizeThatFits)
        }
    }
}
