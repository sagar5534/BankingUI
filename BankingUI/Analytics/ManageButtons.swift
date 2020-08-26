//
//  ManageButtons.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-18.
//

import SwiftUI
import SwiftUICharts

struct ManageButtons: View {
    @State var name: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [ColorGradient.orngPink.startColor, ColorGradient.orngPink.endColor]),
                                     startPoint: .bottom,
                                     endPoint: .top))

                .cornerRadius(5)
            Text(name).fontWeight(.black)
                .padding()
                .foregroundColor(.white)
        }
    }
}

struct ManageButtons_Previews: PreviewProvider {
    static var previews: some View {
        ManageButtons(name: "Testing")
            .frame(width: 200, height: 200, alignment: .center)
    }
}
