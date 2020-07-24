//
//  TagList.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct TagList: View {
   
    @State var isEditMode: EditMode = .inactive
    @State private var tags: TagCollection = [
        Tag(id: 1, name: "Shopping", color: "#FF0000")
    ]

    var body: some View {
        
        List{
            AddRow(name: "Add a Tag")
            ForEach(tags, id: \.self) { tag in
                
                NavigationLink(destination: TagDetail(tag: tag)) {
                    TagRow(name: tag.name ?? "", color: .init(UIColor.init(hex: tag.color ?? "") ?? .red))
                }
               
            }
            .onDelete(perform: delete)

        }
        .listStyle(PlainListStyle())

        .navigationTitle("Tags")
        .navigationBarItems(trailing: EditButton())
        .navigationViewStyle(DefaultNavigationViewStyle())
        .environment(\.editMode, self.$isEditMode)

    }
    
    func delete(at offsets: IndexSet) {
        tags.remove(atOffsets: offsets)
    }
    
}

struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        TagList()
    }
}
