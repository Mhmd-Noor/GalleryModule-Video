//
//  LocalVideoMedia.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 19/10/23.
//

import Foundation
import UIKit
import Photos


class LocalVideoMedia: Media{
   
    let asset: PHAsset
    
    init(asset: PHAsset) {
        self.asset = asset
    }
    
    func loadVideoThumbnails<T: RequestCriteria>(_ loadOptions: T, completion: @escaping (UIImage?) -> Void) {
        let options = PHImageRequestOptions()
        
        // for image delivery mode can be set to all the three but if i am loading video it can only be opportunistic otherwise nil
        options.deliveryMode =  loadOptions.deliveryMode!
        options.isNetworkAccessAllowed = loadOptions.isNetworkAccessAllowed!
        options.isSynchronous = loadOptions.isSynchronous!

        options.resizeMode = loadOptions.resizeMode!
        options.version = loadOptions.version!
        loadOptions.progressHandler = options.progressHandler
       
        
        PHCachingImageManager.default().requestImage(
            for: self.asset,
            targetSize: (loadOptions.isMaximumSizeImage)! == true ? PHImageManagerMaximumSize : CGSize(width: loadOptions.width!, height: loadOptions.height!),
            contentMode: loadOptions.contentMode!,
            options: options) { (image, info) in
               completion(image)
            }

    }
    

}
