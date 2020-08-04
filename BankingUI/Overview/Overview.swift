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
    @State var showingDetail = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Good Evening, Sagar")
                        .bold()
                        .fontWeight(.heavy)
                        .foregroundColor(.secondary)
                        .font(.system(size: 24))
                        .frame(height: 0, alignment: .leading)
                        .padding(.top, 5)
                    Spacer()
                }
                .padding(.leading, 22)
                .padding(.bottom, 10)
                
                Divider()

                // --------------------------------------------------

                ScrollView {
                    VStack(spacing: 20) {
                        Card(showShadow: colorScheme == .light) {
                            HStack {
                                Text("Accounts")
                                    .bold()
                                    .font(.title)
                                    .font(.system(size: 32))
                                    .padding(EdgeInsets(top: 16.0, leading: 8.0, bottom: 0.0, trailing: 8.0))

                                Spacer()
                            }
                            .padding(.top, 15)
                            .padding(.leading, 15)

                            Divider()

                            AccountsOverview(colorScheme: colorScheme)
                                .environmentObject(data)
                                .padding()
                            
                        }
                        
                        HStack{
                            Card(showShadow: colorScheme == .light){
                                
                                ZStack(alignment: .bottom) {
                                    ZStack(alignment: .center) {
                                        Rectangle()
                                            .fill(LinearGradient(gradient: Gradient(colors: [ColorGradient.green.endColor,ColorGradient.green.startColor]),
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
                                    self.showingDetail.toggle()
                                }.sheet(isPresented: $showingDetail) {
                                    TransAmount(showingDetail: $showingDetail).environmentObject(data)
                                }
                                
                                
                            }
                            .aspectRatio(CGSize(width: 16, height: 16), contentMode: .fill)
                            
                            Card{
                                Text("HEY")
                            }
                        }
                        

                    }.padding(.all, 22)
                }

                Spacer()
            }

            .navigationTitle("Overview")
            .navigationBarItems(trailing:
                Button(action: {
                    print(10)
                    //TODO add connection to settings page
                }, label: {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 25, height: 25)
                })
            )
            
        }
    }
}

struct OverviewPage_Previews: PreviewProvider {
    static var previews: some View {
        let data = GlobalData()

        Group {
            OverviewPage()
                .preferredColorScheme(.dark)
                .environmentObject(data)
        }
    }
}
