//
//  Analytics.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-23.
//

import SwiftUI

struct Analytics: View {
    var body: some View {
        
        NavigationView {
            
            
            VStack {
                HStack{
                    Text("Manage")
                        .bold()
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                let names = ["Transactions", "Tags", "Accounts"]
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(names, id: \.self) { name in
                            
                            NavigationLink(destination:
                                Group{
                                    if name == "Transactions"{
                                        TransactionList()
                                    }else if name == "Tags"{
                                        TagList()
                                    }else{
                                        AccountList()
                                    }
                                }) {
                                    
                                ZStack(alignment: .bottomLeading) {
                                    Rectangle().foregroundColor(.blue)
                                        .cornerRadius(5)
                                    Text(name).fontWeight(.black)
                                        .padding()
                                        .foregroundColor(.white)
                                }
                                .frame(width: 200, height: 200)
                            }
                                
                        }
                    }
                }
                .padding(.leading, 10)
                
                Spacer()
            }
            
            .navigationTitle("Analytics")

        }
                
    }
}

struct Analytics_Previews: PreviewProvider {
    static var previews: some View {
        Analytics()
            .preferredColorScheme(.dark)
    }
}

class Observer : ObservableObject{
    @Published var tags = TagCollection()

    init() {
        getTags()
    }
    
    func getTags() {
        let parameter = ["user": 1]
        let url = "http://lunar.local:4000/get/tags"

        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: TagCollection.self) { response in

            switch response.result {
            case let .success(data):
                GlobalData.shared.Tags = data

            case let .failure(err):
                createAlert(self, title: "Error", message: err.errorDescription ?? "Please try again later!")
            }
        }
    }
}

