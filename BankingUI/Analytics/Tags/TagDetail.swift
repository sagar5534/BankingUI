//
//  TagDetail.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct TagDetail: View {
    var tag: Tag
    
    var body: some View {
        List{
            Text("")
        }
        .navigationTitle(tag.name ?? "")
    }
}

struct TagDetail_Previews: PreviewProvider {
    static var previews: some View {
        TagDetail(tag: Tag(id: 1, name: "Shopping", color: ""))
    }
}
