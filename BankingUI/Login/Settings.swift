//
//  Settings.swift
//  BankingUI
//
//  Created by Sagar Patel on 2020-08-04.
//

import SwiftUI

struct Settings: View {
    @State private var currency = 0

    var strengths = ["CAD", "USD"]
    
    @State private var showImagePicker : Bool = false
    @State private var image : Image? = Image("profile")

    
    var body: some View {
        List {
            HStack {
                Spacer()
                VStack{
                    image!.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 6))
                        .shadow(radius: 3)
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                    
                    Button(action: { self.showImagePicker.toggle()}) {
                        Text("Change Image")
                    }
                }
                Spacer()
            }
            

            Section(header: Text("User")) {
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        HStack {
                            Text("Name")
                            Spacer()
                            Text("Sagar")
                                .foregroundColor(Color(UIColor.secondaryLabel))
                        }
                    }
                )

                HStack {
                    Text("Email")
                    Spacer()
                    Text("s.72427patel@gmail.com")
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
            
            }

            Section(header: Text("Accounts")) {
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text("Notifications")
                    }
                )

                Picker(selection: $currency, label: Text("Currency")) {
                    ForEach(0 ..< strengths.count) {
                        Text(self.strengths[$0])
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                }
                
                
                
            }

            Section(header: Text("Terms and Policies")) {
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text("Application Terms")
                    }
                )
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text("Privacy Statement")
                    }
                )
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text("About the Developer")
                    }
                )
            }

            Button(action: {
                // your action here
                print("what up")
            }) {
                Text("Sign Out")
                    .foregroundColor(.red)
            }

            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .listStyle(InsetGroupedListStyle())
        //.environment(\.horizontalSizeClass, .regular)

        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
        
        .sheet(isPresented: self.$showImagePicker){
            PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
        }
    }

}

struct ImagePicker : UIViewControllerRepresentable {
    
    @Binding var isShown    : Bool
    @Binding var image      : Image?
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePickerCordinator {
        return ImagePickerCordinator(isShown: $isShown, image: $image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
}

class ImagePickerCordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @Binding var isShown    : Bool
    @Binding var image      : Image?
    
    init(isShown : Binding<Bool>, image: Binding<Image?>) {
        _isShown = isShown
        _image   = image
    }
    
    //Selected Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image = Image(uiImage: uiImage)
        isShown = false
    }
    
    //Image selection got cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}

struct PhotoCaptureView: View {
    
    @Binding var showImagePicker    : Bool
    @Binding var image              : Image?
    
    var body: some View {
        ImagePicker(isShown: $showImagePicker, image: $image)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Settings()
        }
    }
}
