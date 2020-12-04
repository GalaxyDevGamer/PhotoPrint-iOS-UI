//
//  ContentView.swift
//  PhotoPrint UI
//
//  Created by GINGA WATANABE on 2019/06/22.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import SwiftUI
import Photos

struct ContentView : View {
    let controller = UIPrintInteractionController.shared
    let printInfo = UIPrintInfo(dictionary: nil)
    @State var showError = false
    @State var errorReason = ""
    @ObservedObject var model = ContentViewModel()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @ViewBuilder
    var body: some View {
        if model.isAuthorized {
            ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 20) {
                        ForEach((0...model.photos.count), id: \.self) {
                            let index = $0 % model.photos.count
                            Button(action: {
                                self.printInfo.outputType = UIPrintInfo.OutputType.photo
                                self.printInfo.jobName = "Photo Print from iPhone"
                                self.printInfo.orientation = UIPrintInfo.Orientation.portrait
                                self.controller.printInfo = self.printInfo
                                self.controller.printingItem = model.photos[index].asset.getOriginalImage().resizeForA4()
                                self.controller.present(animated: true) { (controller, bool, error) in
                                    if error != nil {
                                        self.showError = true
                                        self.errorReason = error!.localizedDescription
                                    }
                                }
                            }, label: {
                                Image(uiImage: model.photos[index].image)
                            })
                    }
            }
            }.alert(isPresented: self.$showError, content: {
                Alert(title: Text(self.errorReason))
            }).navigationBarTitle(Text("Select the image to print")).onAppear(perform: {
                if !self.model.isAuthorized {
                    self.model.requestAuthentication()
                }
            })
        } else {
            VStack(alignment: HorizontalAlignment.center, spacing: 16) {
                Text("You need to grant access to the photos")
                Button(action: {
                    model.requestAuthentication()
                }) {
                    Text("Grant Access")
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
