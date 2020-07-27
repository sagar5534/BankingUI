//
//  TagColor.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-26.
//

import SwiftUI
import Alamofire

struct TagColor: View {

    @EnvironmentObject var observed: GlobalData
    @EnvironmentObject var TagData: NewTagData
    
    @Binding var showingDetail: Bool
    @State private var showingAlert = false
    @State private var selected: Index = Index(row: 0, col: 0)

    var body: some View {
        let colors = [
            [
                Color(UIColor(red: 0.10, green: 0.74, blue: 0.61, alpha: 1.00)),
                Color(UIColor(red: 0.20, green: 0.60, blue: 0.86, alpha: 1.00)),
                Color(UIColor(red: 0.61, green: 0.35, blue: 0.71, alpha: 1.00)),
                Color(UIColor(red: 0.95, green: 0.77, blue: 0.06, alpha: 1.00)),
            ],
            [
                Color(UIColor(red: 0.91, green: 0.30, blue: 0.24, alpha: 1.00)),
                Color(UIColor(red: 0.17, green: 0.24, blue: 0.31, alpha: 1.00)),
                Color(UIColor(red: 0.90, green: 0.49, blue: 0.13, alpha: 1.00)),
                Color(UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1.00)),
            ],
        ]

        VStack(alignment: .center, spacing: 10) {
            HStack {
                Text("Pick a color for " + TagData.name)
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

            VStack(spacing: 20) {
                ForEach(colors.indices, id: \.self) { row in
                    HStack(spacing: 20) {
                        ForEach(colors[row].indices, id: \.self) { color in
                            ZStack {
                                BorderedCircle(color: colors[row][color])
                                    .frame(width: 40, height: 40)

                                if selected.row == row && selected.col == color {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                }
                            }.onTapGesture {
                                selected.row = row
                                selected.col = color
                                TagData.color = UIColor(colors[selected.row][selected.col]).toHexString()
                            }
                        }
                    }
                }
            }.padding()
            
            Spacer()
        }
        .padding(.leading, 20)
        .navigationTitle("Create a Tag")
        .navigationBarItems(
            trailing: Button(action: {
                createCall(name: TagData.name, color: TagData.color)
            }, label: {
                Text("Done")
            })
        )
        .onAppear {
            TagData.color = UIColor(colors[selected.row][selected.col]).toHexString()
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Sorry!"),
                message: Text("An Error Occured"),
                primaryButton: .default(Text("Try Again"), action: {
                    createCall(name: TagData.name, color: TagData.color)
                }),
                secondaryButton: .cancel({
                    self.showingDetail.toggle()
                }))
        }
    }
    
    func createCall(name: String, color: String) {
        let url = "http://lunar.local:4000/" + "create/tag"
        let parameter = [
            "user": 1,
            "name": name,
            "color": color,
        ] as [String: Any]
        
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: Tag.self) { response in

            switch response.result {
            case let .success(data):
                observed.tags.append(data)
                self.showingDetail.toggle()
            case let .failure(err):
                showingAlert.toggle()
            }
        }
    }
    
}

struct TagColor_Previews: PreviewProvider {
    static var previews: some View {
        let data = NewTagData()

        NavigationView {
            TagColor(showingDetail: .constant(true)).environmentObject(data)
        }
        
    }
}
