//
//  PhotoManager.swift
//  PhotoPrint UI
//
//  Created by GINGA WATANABE on 2019/06/22.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import UIKit
import SwiftUI
import PhotoLibrary
import Photos

class ContentViewModel: ObservableObject {
    
    let library = PhotoLibrary()
    
    var photos = [Photo]()
    
    var uiphotos = [Image]()
    
    var assets: PHFetchResult<PHAsset>!
    
    @Published var isAuthorized = false
    
    init() {
        isAuthorized = library.isAuthorized()
        if isAuthorized {
            getAllPhotos()
        }
    }
    
    func requestAuthentication() {
        if !library.isAuthorized() {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    self.getAllPhotos()
                    DispatchQueue.main.async {
                        self.isAuthorized = true
                    }
                default:
                    break
                }
            }
        }
    }
    
    func getAllPhotos() {
        if library.isAuthorized() {
            self.assets = library.getAllPhotos()
            for index in stride(from: 0, to: assets.count, by: 1) {
                photos.append(Photo(id: index, image: assets.object(at: index).getImagesForCollection(), asset: assets.object(at: index)))
            }
        }
    }
}
