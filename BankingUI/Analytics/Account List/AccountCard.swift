//
//  ScrollingAccounts.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-05.
//

import SwiftUI

struct AccountCard: View {
    @State var account: Account
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var color: Int

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .foregroundColor(getColor(index: color))
                .cornerRadius(8)

            VStack {
                HStack {
                    Image(getImage(type: account.type!)).resizable()
                        .frame(width: 35, height: 35)
                    Spacer()
                    Text(account.type!)
                        .font(.caption)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
                Spacer()
                Leading {
                    Text(account.desc!)
                        .bold()
                }
                .padding(.bottom, 5)
                Leading {
                    Text(account.totalValue!.toMoney())
                        .font(.system(size: 19, weight: Font.Weight.light))
                }
            }
            .padding()
        }
    }

    func getColor(index: Int) -> Color {
        let colors = [
            "#686de0",
            "#ff6b6b",
            "#1dd1a1",
            "#54a0ff",
            "#ff9ff3",
            "#feca57",
        ]

        return Color(UIColor(hex: colors[index % colors.count])!)
    }

    func getImage(type: String) -> String {
        var string = ""

        switch type {
        case "BANK":
            string = colorScheme == .light ? "bank-black" : "bank-white"
        case "CREDIT":
            string = colorScheme == .light ? "card-black" : "card-white"
        case "CASH":
            string = colorScheme == .light ? "piggy-black" : "piggy-white"
        case "NET":
            string = colorScheme == .light ? "chart-black" : "chart-white"
        default:
            string = colorScheme == .light ? "piggy-black" : "piggy-white"
        }

        return string
    }
}

struct ScrollingAccounts_Previews: PreviewProvider {
    static var previews: some View {
        AccountCard(account: Account(id: 7, type: "CREDIT", desc: "My Credit", totalValue: 988.80), color: 1)
            .frame(width: 150, height: 250)
    }
}
