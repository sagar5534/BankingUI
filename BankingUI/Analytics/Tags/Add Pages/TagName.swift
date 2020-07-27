//
//  AddTag.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-24.
//

import SwiftUI
import Alamofire


class NewTagData: ObservableObject {
    @Published var name = ""
    @Published var color = ""
}
struct Index {
    var row: Int
    var col: Int
}


struct TagName: View {
    
    @Binding var showingDetail: Bool

    @State private var showingAlert = false
    @State private var TagData = NewTagData()
    @State private var text: String = ""

    var body: some View {
        NavigationView {
            GeneralTextField(title: "Name your new Tag", text: $text)
                .onChange(of: text) { value in
                    TagData.name = value
                }
                
            .navigationTitle("Create a Tag")
            .navigationBarItems(
                leading: Button("Cancel") {
                    self.showingDetail.toggle()
                }, trailing: NavigationLink(
                    destination: TagColor(showingDetail: $showingDetail).environmentObject(TagData),
                    label: {
                        Text("Next")
                    }
                ).disabled(text.isEmpty)
            )
        }

    }
}

struct AddTag_Previews: PreviewProvider {
    
    @State var datal = NewTagData()

    static var previews: some View {
        
        let data = NewTagData()

        TagName(showingDetail: .constant(true)).environmentObject(data)
            
    }
}
