//
//  LocalVideoMedia.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 19/10/23.
//

import Foundation
import UIKit
import Photos


class LocalVideoMedia: Video<LocalVideoRequest>{
   
    let asset: PHAsset
    
    init(asset: PHAsset) {
        self.asset = asset
    }
    
    override func loadVideoData(loadOptions: LocalVideoRequest, completion: @escaping (UIImage?) -> Void) {
        
        let options = PHImageRequestOptions()
        
        options.deliveryMode =  loadOptions.deliveryMode!
        options.isNetworkAccessAllowed = loadOptions.isNetworkAccessAllowed!
        options.isSynchronous = loadOptions.isSynchronous!

        options.resizeMode = loadOptions.resizeMode!
        options.version = loadOptions.version!
        loadOptions.progressHandler = options.progressHandler
       
        
        PHCachingImageManager.default().requestImage(
            for: self.asset,
            targetSize: CGSize(width: loadOptions.width!, height: loadOptions.height!),
            contentMode: loadOptions.contentMode!,
            options: options) { (image, info) in
                
                // When degraded image is provided, the completion handler will be called again.
                guard !(info?[PHImageResultIsDegradedKey] as? Bool ?? false) else { return }
                completion(image)
                
            }

    }
    

}
