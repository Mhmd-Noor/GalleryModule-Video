//
//  LocalVideoGroupCollector.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 23/10/23.
//

import Foundation
import Photos

class LocalVideoGroupCollector: MediaGroupCollector<LocalVideoGroupMedia, LocalVidoeGroupRequest> {
    
    override func getMediaCategoryData(_ request: LocalVidoeGroupRequest,
                                       _ isPaginated: Bool) -> MediaResult<LocalVideoGroupMedia> {
        
        var totalAlbums: [LocalVideoGroupMedia] = []
        let mediaResult = MediaResult<LocalVideoGroupMedia>()
        
        let fetchAssetCollectionOptions = PHFetchOptions()
        
        let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchAssetCollectionOptions)
            //
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: fetchAssetCollectionOptions)
         
            print("album count is \(albums.count)")
        
        albums.enumerateObjects { album, index, stop in
            totalAlbums.append(LocalVideoGroupMedia(album))
        }
        smartAlbums.enumerateObjects { album, index, stop in
            totalAlbums.append(LocalVideoGroupMedia(album))
        }
        mediaResult.allMedia = totalAlbums
        
        return mediaResult
        
    }
    
}
