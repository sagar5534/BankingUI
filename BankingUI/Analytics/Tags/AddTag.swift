//
//  AddTag.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-24.
//

import SwiftUI
import UIKit

class NewTag: ObservableObject {
    @Published var name = ""
    @Published var color = ""
}

struct AddTagName: View {
    // Comes from TagList
    @EnvironmentObject var data: NewTag
    @Environment(\.presentationMode) var presentationMode
    @State private var text = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    Text("Name your new Tag")
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
                TextField(
                    "type something...",
                    text: $data.name,
                    onEditingChanged: { _ in print("changed") },
                    onCommit: { print("commit") }
                )
                .textFieldStyle(PlainTextFieldStyle())
                .multilineTextAlignment(.leading)
                .font(.system(size: 50, weight: .light))
                Spacer()
            }
            .padding(.leading, 20)
            .navigationTitle("Create a Tag")
            .navigationBarItems(
                leading: Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }, trailing: NavigationLink(
                    destination: AddTagColor(),
                    label: {
                        Text("Next")
                    }
                )
            )
        }
    }
}

struct Index {
    var row: Int
    var col: Int
}

struct AddTagColor: View {
    // Comes from TagList
    @EnvironmentObject var data: NewTag
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
                Text("Pick a color for Tag")
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
                                print(UIColor(colors[selected.row][selected.col]).toHexString())
                                data.color = UIColor(colors[selected.row][selected.col]).toHexString()
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
            trailing: NavigationLink(
                destination: AddTagName(),
                label: {
                    Text("Done")
                }
            )
        )
        .onAppear {
            data.color = colors[selected.row][selected.col].description
            print(UIColor(colors[selected.row][selected.col]).toHexString())
        }
    }
}

struct AddTag_Previews: PreviewProvider {
    static var previews: some View {
        let data = NewTag()

        Group {
            AddTagName().environmentObject(data)
            NavigationView {
                AddTagColor().environmentObject(data)
            }
        }
    }
}
