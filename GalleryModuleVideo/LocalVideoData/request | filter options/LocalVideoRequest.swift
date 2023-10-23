//
//  LocalVideoRequestCriteria.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 19/10/23.
//

import Foundation
import Photos
import UIKit


class LocalVideoRequest {
    
    //MARK: Media Fetching options
    var fetchLimit : Int? = 0
    var includeAllBurstAssets: Bool? = false
  //  var includeAssetSourceTypes = .typeUserLibrary // default
    var includeHiddenAssets: Bool? = false
   // fetchOptions.wantsIncrementalChangeDetails = true
    var height: CGFloat? = 300
    var width: CGFloat? = 400
    var predicate = Predicate()
    var sortDescriptors : [NSSortDescriptor] = []
    var defultAlbumTitle: String? = "Recents"
    var selectedAlbum: PHAssetCollection?
 
    
    //MARK: Media Loading options
    var deliveryMode: PHImageRequestOptionsDeliveryMode? = .opportunistic
    var isSynchronous: Bool? = false
    var normalizedCropRect: CGRect? = .zero
    var isMaximumSizeImage: Bool? = false
    private var _resizeMode: PHImageRequestOptionsResizeMode = .exact
    var resizeMode: PHImageRequestOptionsResizeMode?{
        get {
            return normalizedCropRect != .zero ? .exact : PHImageRequestOptionsResizeMode.exact
                
        }
        set(newValue) {
            _resizeMode = normalizedCropRect != .zero ? .exact:  newValue!
        }
    }
    var version: PHImageRequestOptionsVersion? = .current
    var contentMode: PHImageContentMode? = .aspectFit
    // iCloud
    var isNetworkAccessAllowed: Bool? = false
    // if isNetworkAccessAllowed is true, this handler will give, progress(0.0 to 1.0 floating point number), error(NSError), stop (bool), info
    var progressHandler: PHAssetImageProgressHandler?
    
    
    // MARK: Video Fetching options
    var videoDeliveryMode: PHVideoRequestOptionsDeliveryMode? = .automatic
    var videoVersion: PHVideoRequestOptionsVersion? = .current
    var videoQuality: PHImageRequestOptionsDeliveryMode? = .highQualityFormat
    var videoTimeRange: CMTimeRange?
    
    // MARK: Video Loading options
    var isNetworkAccessAllowedForVideo: Bool? = false
    var progressHandlerForVideo: PHAssetVideoProgressHandler?
    
}


class LocalVideoRequestBuilder {
    private var requestCriteria: LocalVideoRequest = LocalVideoRequest()

    func setFetchLimit(_ fetchLimit: Int) -> Self {
        requestCriteria.fetchLimit = fetchLimit
        return self
    }

    func setIncludeAllBurstAssets(_ includeAllBurstAssets: Bool) -> Self {
        requestCriteria.includeAllBurstAssets = includeAllBurstAssets
        return self
    }

    func setIncludeHiddenAssets(_ includeHiddenAssets: Bool) -> Self {
        requestCriteria.includeHiddenAssets = includeHiddenAssets
        return self
    }

    func setHeight(_ height: CGFloat) -> Self {
        requestCriteria.height = height
        return self
    }
    

    func setWidth(_ width: CGFloat) -> Self {
        requestCriteria.width = width
        return self
    }
    func setPredicate(_ predicate: Predicate) -> Self {
        requestCriteria.predicate = predicate
        return self
    }
    func setSortDescriptors(_ sortDescriptors: Sort... ) -> Self {
        for sort in sortDescriptors {
            requestCriteria.sortDescriptors.append(sort.sortDescriptor)
        }
        return self
    }
    
    func setDefultAlbumTitle(_ title: String) -> Self {
        requestCriteria.defultAlbumTitle = title
        return self
    }
    func setSelectedAlbum(_ album: PHAssetCollection) -> Self {
        requestCriteria.selectedAlbum = album
        return self
    }
    
    
    // ImageLoading Options
    func setDeliveryMode(_ deliveryMode: PHImageRequestOptionsDeliveryMode) -> Self {
        requestCriteria.deliveryMode = deliveryMode
        return self
    }
    
    func setIsSynchronous(_ isSynchronous: Bool) -> Self {
        requestCriteria.isSynchronous = isSynchronous
        return self
    }
    func setContentMode(_ contentMode: PHImageContentMode) -> Self {
        requestCriteria.contentMode = contentMode
        return self
    }
    func setNormalizedCropRect(_ normalizedRect: CGRect) -> Self {
        requestCriteria.normalizedCropRect = normalizedRect
        return self
    }
    func setIsMaximumSizeImage(_ isMaximumSizeImage: Bool) -> Self {
        requestCriteria.isMaximumSizeImage = isMaximumSizeImage
        return self
    }
    func setResizeMode(_ resizeMode: PHImageRequestOptionsResizeMode) -> Self {
        requestCriteria.resizeMode = resizeMode
        return self
    }
    
    func setVersion(_ version: PHImageRequestOptionsVersion)-> Self {
        requestCriteria.version = version
        return self
    }
    
    func setIsNetworkAccessAllowed(_ isNetworkAccessAllowed: Bool) -> Self {
        requestCriteria.isNetworkAccessAllowed =
        isNetworkAccessAllowed
        return self
    }
    
    func build() -> LocalVideoRequest {
        return self.requestCriteria
    }
    
    
}
