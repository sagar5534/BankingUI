//
//  AddRow.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct AddRow: View {

    var name: String

    var body: some View {
        HStack {
            Image(systemName: "plus.circle.fill").resizable()
                .foregroundColor(.blue)
                .frame(width: 40.0, height: 40.0)
                .padding(.trailing, 4)
            Text(name)
                .bold()
                .font(.system(size: 18))
            Spacer()
        }
        .padding()
    }
}


struct AddRow_Previews: PreviewProvider {
    static var previews: some View {
        AddRow(name: "Add an account")
            .previewLayout(.sizeThatFits)
    }
}
