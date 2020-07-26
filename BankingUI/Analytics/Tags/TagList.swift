//
//  TagList.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct TagList: View {
    
    @EnvironmentObject var data: GlobalData

    @State var isEditMode: EditMode = .inactive
    @State var showingDetail = false

    var newTag = NewTagData()

    var body: some View {
        List {
            AddRow(name: "Add a Tag")
                .onTapGesture {
                    self.showingDetail.toggle()
                }
            ForEach(data.tags, id: \.self) { tag in

                NavigationLink(destination: TagDetail(tag: tag)) {
                    TagRow(name: tag.name ?? "", color: .init(UIColor(hex: tag.color ?? "") ?? .red))
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(PlainListStyle())

        .navigationTitle("Tags")
        .navigationBarItems(trailing: EditButton())
        .navigationViewStyle(DefaultNavigationViewStyle())
        .environment(\.editMode, self.$isEditMode)
        .sheet(isPresented: $showingDetail) {
            AddTagName(showingDetail: $showingDetail).environmentObject(newTag).environmentObject(data)
        }
    }

    func delete(at offsets: IndexSet) {
        data.deleteTag(id: offsets.first!)
        data.tags.remove(atOffsets: offsets)
    }
}

struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        
        let observed = GlobalData()
        
        NavigationView{
            TagList()
                .environmentObject(observed)
        }
        
    }
}
