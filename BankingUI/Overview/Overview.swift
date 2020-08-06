//
//  Overview.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-07-27.
//

import SwiftUI
import SwiftUICharts

struct OverviewPage: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var data: GlobalData

    var blueStlye = ChartStyle(backgroundColor: ColorGradient.orangeBright, foregroundColor: .prplPink)
    @State var showingAddTrans = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Card(showShadow: colorScheme == .light) {
                                ZStack(alignment: .bottom) {
                                    ZStack(alignment: .center) {
                                        Rectangle()
                                            .fill(LinearGradient(gradient: Gradient(colors: [ColorGradient.green.endColor, ColorGradient.green.startColor]),
                                                                 startPoint: .bottom,
                                                                 endPoint: .top))

                                            .cornerRadius(5)

                                        Text("+")
                                            .font(.largeTitle)
                                            .fontWeight(.black)
                                            .foregroundColor(.white)
                                    }

                                    HStack {
                                        Text("Add\nTransaction").fontWeight(.black)
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .padding()

                                }.onTapGesture {
                                    self.showingAddTrans.toggle()
                                }.sheet(isPresented: $showingAddTrans) {
                                    TransAmount(showingDetail: $showingAddTrans).environmentObject(data)
                                }
                            }
                            .aspectRatio(CGSize(width: 16, height: 16), contentMode: .fill)
                        }

                    }.padding(.all, 22)
                }

                Spacer()
            }

            .navigationTitle("👋🏻 Hello Sagar")
            .navigationBarItems(trailing:
                NavigationLink(
                    destination: Settings(),
                    label: {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                )
            )
        }
    }
}

struct OverviewPage_Previews: PreviewProvider {
    static var previews: some View {
        let data = GlobalData()
        OverviewPage()
            .preferredColorScheme(.dark)
            .environmentObject(data)
    }
}
