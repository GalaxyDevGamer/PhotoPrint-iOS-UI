//
//  Photo.swift
//  PhotoPrint UI
//
//  Created by GINGA WATANABE on 2019/06/22.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import Foundation
import SwiftUI
import Photos

struct Photo: Identifiable {
    var id: Int
    var image: UIImage
    var asset: PHAsset
}
