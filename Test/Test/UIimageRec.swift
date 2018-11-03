//
//  File.swift
//  Test
//
//  Created by Lucca Paletta on 11/3/18.
//  Copyright © 2018 Lucca Paletta. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {



    func resizeUIImage(size: CGSize)-> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, true, self.scale)
        self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}

    // MARK: - UIImage+Resize
//    func compressTo(_ expectedSizeInMb:Int) -> UIImage? {
//        let sizeInBytes = expectedSizeInMb * 1024 * 1024
//        var needCompress:Bool = true
//        var imgData:Data?
//        var compressingValue:CGFloat = 1.0
//        while (needCompress && compressingValue > 0.0) {
//            if let data:Data = UIImage.jpegData(jpegData(compressionQuality: compressingValue)){
//            if let data:Data = UIImageJPEGRepresentation(self, compressingValue) {
//                if data.count < sizeInBytes {
//                    needCompress = false
//                    imgData = data
//                } else {
//                    compressingValue -= 0.1
//                }
//            }
//        }
    

        
//        if let data = imgData {
//            if (data.count < sizeInBytes) {
//                return UIImage(data: data)
//            }
//        }
//        return nil
//    }
//
//
//    func resizeImage(image: UIImage) -> UIImage {
//        var actualHeight: Float = Float(image.size.height)
//        var actualWidth: Float = Float(image.size.width)
//        let maxHeight: Float = 300.0
//        let maxWidth: Float = 400.0
//        var imgRatio: Float = actualWidth / actualHeight
//        let maxRatio: Float = maxWidth / maxHeight
//        let compressionQuality: Float = 0.5
//        //50 percent compression
//
//        if actualHeight > maxHeight || actualWidth > maxWidth {
//            if imgRatio < maxRatio {
//                //adjust width according to maxHeight
//                imgRatio = maxHeight / actualHeight
//                actualWidth = imgRatio * actualWidth
//                actualHeight = maxHeight
//            }
//            else if imgRatio > maxRatio {
//                //adjust height according to maxWidth
//                imgRatio = maxWidth / actualWidth
//                actualHeight = imgRatio * actualHeight
//                actualWidth = maxWidth
//            }
//            else {
//                actualHeight = maxHeight
//                actualWidth = maxWidth
//            }
//        }
//
//
//
//        let rect = CGRect(x: 0, y: 0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
//
//
//        UIGraphicsBeginImageContext(rect.size)
//        image.draw(in: rect)
//
//
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//
//        let imageData = UIimage.jpegData()
//
//        let imageData = UIImageJPEGRepresentation(img!,CGFloat(compressionQuality))
//        UIGraphicsEndImageContext()
//        return UIImage(data: imageData!)!
//    }
//
//}
