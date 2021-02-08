//
//  ImageManager.swift
//  Rizzle
//
//  Created by Keertika Gupta on 10/10/20.
//  Copyright © 2020 Keertika Gupta. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class ImageManager:NSObject {
    static var shared = ImageManager()
     var queue = OperationQueue()
     var cache = NSCache<AnyObject, AnyObject>()
    
    private override init() {
        
    }
    
    
    
     func getThumbnailImage(forUrl url: URL) -> UIImage? {
         let asset: AVAsset = AVAsset(url: url)
         let imageGenerator = AVAssetImageGenerator(asset: asset)

         do {
             let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
             return UIImage(cgImage: thumbnailImage)
         } catch let error {
             print(error)
         }

         return  nil

     }
    
    
//    func downloadImage(url:URL,cacheKey:AnyObject, completionBlock:@escaping (_  image:UIImage?)->())->BlockOperation?{
//        if let cachedImage = ImageManager.shared.cache.object(forKey: cacheKey) as? UIImage{
//            completionBlock(cachedImage)
//        }else{
//            //  download Image and return operation
//            var image: UIImage?
//             let operation = BlockOperation(block: {[weak self] in
//                image  = self?.getThumbnailImage(forUrl :  url) //Downloader.downloadImageWithURl(self.imageURLs[indexPath.row])
//            })
//
//            operation.completionBlock =
//
////            ImageManager.shared.queue.addOperation(operation)
//            return operation
//
//           }
//            return nil
//    }
    

}
