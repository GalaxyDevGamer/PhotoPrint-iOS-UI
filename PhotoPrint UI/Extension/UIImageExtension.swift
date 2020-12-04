//
//  UIImageExtension.swift
//  PhotoPrint UI
//
//  Created by GINGA WATANABE on 2019/06/22.
//  Copyright © 2019 GalaxySoftware. All rights reserved.
//

import Foundation
import SwiftUI

extension UIImage {
    func resizeForA4() -> Image {
        let size = CGSize(width: 2480, height: 3508)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Image(uiImage: image!)
    }
}
