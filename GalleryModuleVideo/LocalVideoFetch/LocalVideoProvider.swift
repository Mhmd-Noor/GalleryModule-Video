//
//  LocalVideoProvider.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 19/10/23.
//

import Foundation
import Photos



class LocalVideoProvider: MediaProvider{
    
    var allMedia : [Int: Media] = [:]
    
    func getMediaData<T: RequestCriteria>(fetchOptions: T) -> [Int: Media] {
        
        // different fetching options
        let fetchAssetOptions = PHFetchOptions()
        let fetchAssetCollectionOptions = PHFetchOptions()
        
//        fetchAssetOptions.sortDescriptors = fetchOptions.sortDescriptors
        //fetchAssetOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fetchAssetOptions.fetchLimit = fetchOptions.fetchLimit!
        fetchAssetOptions.includeAllBurstAssets = fetchOptions.includeAllBurstAssets!
        fetchAssetOptions.includeHiddenAssets = fetchOptions.includeHiddenAssets!
        // fetchOptions.wantsIncrementalChangeDetails = true
        // fetchOptions.includeAssetSourceTypes
        
        fetchAssetOptions.predicate = fetchOptions.predicate.getPredicate()
       // fetchAssetOptions.predicate = NSPredicate(format: "duration >= %d", argumentArray: [3])
       
        let albums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: fetchAssetCollectionOptions)
        //
        print(albums.count)
        // here we will push in PHFetchOption for asset and for PHFecthOption for assetCollection
    
        

        albums.enumerateObjects { album, albumIndex, stop in
            // print(albumIndex)
           
            let results = PHAsset.fetchAssets(in: album, options: fetchAssetOptions)
            print("\(album.localizedTitle) has \(results.count) assets")
            
            if album.localizedTitle == fetchOptions.defultAlbumTitle! {
                print("yess")
            }
            // var idx = 0
            results.enumerateObjects { [self] asset, assetIndex, stop in
                //  print("asset is\(asset.mediaType.rawValue)")
                
                // if asset.mediaType == .image{
                
                //MARK: Gif identifying
                let assetResource = PHAssetResource.assetResources(for: asset)
                //
                let assetUTI = assetResource.first?.originalFilename.lowercased()
                
                allMedia[assetIndex] = LocalVideoMedia(asset: asset)
                
            }
        }
        return allMedia
        
    }
    
    func getCategoryData() {
        
    }
    
    func getPaginatedMediaData() {
        
    }
    
    func getPaginatedCategoryData() {
        
    }
    
    
}
