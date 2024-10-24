//
//  SettingsView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 6/12/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @State var barcode = Barcode()
    @State var data  = String()
    @State private var isRegistered = false
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Display"),
                        footer: Text("System setttings will override Dark Mode and use the current device theme")){
                    Toggle(isOn: .constant(true), label: {
                        Text("Dark mode")
                    })
                    
                    Toggle(isOn: .constant(true), label: {
                        Text("Use system settings")
                    })
                }
                
                
                
                Section (header: Text("BetterGrade Registeration"),footer: Text("App register/de-register will erase all local stored information")){
                    Toggle(isOn: $isRegistered, label: {
                        Text("Enable/Disable")
                    })
                    .onChange(of: isRegistered){ value in
                        if (isRegistered == false){
                            UserDefaults().setValue("", forKey: "phonenumber")
                            SetupViewModel().deRegister()
                            AppManager.Authenticated.send(false)
                        }
                    }
                }
                Section{
                    Label ("Follow me on twitter @anikagogineni", systemImage: "link")
                }
                
                Section{
//                    if(self.barcode.data != nil){
//                        Image(uiImage: generateQRCode(from: "\(self.barcode.data)") ?? "Barcode missing")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 200, height: 200)
//                    }
//                    Image(uiImage: UIImage(data: getQRCodeDate(text: self.data)!)!)
//                                    .resizable()
//                                    .frame(width: 200, height: 200)
                }
            }
            .navigationTitle("Settings")
            .onAppear(){
//                SettingsViewModel().getBarcode(){ barcode in
//                    self.barcode = barcode
//
//                    self.data = base64Decoded(word: barcode.data)!
//                }
                var pnumber = UserDefaults().string(forKey: "phonenumber")
                if (pnumber != "") {
                    self.isRegistered = true
                }else{
                    self.isRegistered = false
                }
                
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

func getQRCodeDate(text: String) -> Data? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = text.data(using: .ascii, allowLossyConversion: false)
        filter.setValue(data, forKey: "inputMessage")
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()!
    }

func base64Decoded(word: String) -> String? {
    guard let base64Data = Data(base64Encoded: word) else { return nil}
    return String(data: base64Data, encoding: .utf8)
}
