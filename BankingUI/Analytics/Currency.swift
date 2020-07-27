//
//  Currency.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-27.
//

import SwiftUI

struct Currency: View {
    
    @State var title: String
    @State var options: [String]

    @Binding var value: Double?
    @Binding var selected: Int
    
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
            CurrencyTextField("Amount", value: $value)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .multilineTextAlignment(TextAlignment.leading)
            
            Picker(selection: $selected, label: Text("")) {
                ForEach(0 ..< options.count) {
                    Text(options[$0])
                }
            }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.trailing, 20)
                .padding(.top, 10)
                  
            
            Spacer()
        }
        .padding(.leading, 20)
        
    }
}

struct Currency_Previews: PreviewProvider {
    static var previews: some View {
        //Currency()
        Text("")
    }
}
