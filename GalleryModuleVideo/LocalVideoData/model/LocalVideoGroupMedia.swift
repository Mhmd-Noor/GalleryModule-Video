//
//  LocalGroupMedia.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 23/10/23.
//

import Foundation
import Photos

class LocalVideoGroupMedia: Video<LocalVidoeGroupRequest> {
    let assetCollection: PHAssetCollection
    
    init(_ assetCollection: PHAssetCollection){
        self.assetCollection = assetCollection
    }
}
