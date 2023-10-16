//
//  PHFetchResultCollection.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 16/10/23.
//

import Foundation
import Photos

struct PHFetchResultCollection: RandomAccessCollection, Equatable {

    typealias Element = PHAsset
    typealias Index = Int

    var fetchResult: PHFetchResult<PHAsset>

    var endIndex: Int { fetchResult.count }
    var startIndex: Int { 0 }

    subscript(position: Int) -> PHAsset {
        fetchResult.object(at: fetchResult.count - position - 1)
    }
}
