//
//  LocalVideoCollector.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 23/10/23.
//

import Foundation
import Photos

class LocalVideoCollector: MediaCollector<LocalVideoMedia, LocalVideoRequest> {
    
    override func getMediaData(_ request: LocalVideoRequest, _ isPaginated: Bool) -> MediaResult<LocalVideoMedia> {
        
        var allMedia: [LocalVideoMedia] = []
        let mediaResult = MediaResult<LocalVideoMedia>()
        
        // different fetching options
        let fetchAssetOptions = PHFetchOptions()
        let fetchAssetCollectionOptions = PHFetchOptions()
        
        //        fetchAssetOptions.sortDescriptors = fetchOptions.sortDescriptors
        //fetchAssetOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fetchAssetOptions.fetchLimit = request.fetchLimit!
        fetchAssetOptions.includeAllBurstAssets = request.includeAllBurstAssets!
        fetchAssetOptions.includeHiddenAssets = request.includeHiddenAssets!
        // fetchOptions.wantsIncrementalChangeDetails = true
        // fetchOptions.includeAssetSourceTypes
        
        //fetchAssetOptions.predicate = mediaRequest.predicate.getPredicate()
        
        var  results = PHFetchResult<PHAsset>()
        results = PHAsset.fetchAssets(in: request.selectedAlbum!, options: fetchAssetOptions)
        
        results.enumerateObjects { asset, assetIndex, stop in
            
            allMedia.append(LocalVideoMedia(asset: asset))
            
        }
        
        mediaResult.allMedia = allMedia
        
        return mediaResult
        
    }
    
}
