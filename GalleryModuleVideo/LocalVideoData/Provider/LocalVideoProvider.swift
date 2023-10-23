//
//  LocalVideoProvider.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 19/10/23.
//

import Foundation
import Photos

class LocalMediaProvider: MediaProvider {
    // Image Supplier
    var localVideoSupplier: MediaSupplier<LocalVideoMedia, LocalVideoRequest>?
    // Album Supplier
    var localVideoGroupSupplier: MediaGroupSupplier<LocalVideoGroupMedia, LocalVidoeGroupRequest>?
    
    init(localVideoSupplier: MediaSupplier<LocalVideoMedia, LocalVideoRequest>,
         localVideoGroupSupplier: MediaGroupSupplier<LocalVideoGroupMedia, LocalVidoeGroupRequest>) {
        self.localVideoSupplier = localVideoSupplier
        self.localVideoGroupSupplier = localVideoGroupSupplier
        
    }
    
    
    func getVideos(localVideoRequest: LocalVideoRequest, isPaginated: Bool) -> MediaResult<LocalVideoMedia> {
        print("Here in Local Media Provider")
        return (localVideoSupplier?.getVideoData(localVideoRequest, isPaginated))!
    }
    
    func getVideoGroups(localVideoGroupRequest: LocalVidoeGroupRequest,
                        isPaginated: Bool) -> MediaResult<LocalVideoGroupMedia> {
        return (localVideoGroupSupplier?.getVideoGroupData(localVideoGroupRequest, isPaginated))!
    }
    
    
}


class LocalMediaProviderBuilder {
    // Image Supplier
    private var localVideoSupplier: MediaSupplier<LocalVideoMedia, LocalVideoRequest>?
    // Album Supplier
    private var localVideoGroupSupplier: MediaGroupSupplier<LocalVideoGroupMedia, LocalVidoeGroupRequest>?

    func setLocalVideoCollector(_ collector: MediaCollector<LocalVideoMedia, LocalVideoRequest>) -> LocalMediaProviderBuilder {
        self.localVideoSupplier = MediaSupplier(mediaCollector: collector)
        return self
    }
    func setLocalVideoGroupCollector(_ collector: MediaGroupCollector<LocalVideoGroupMedia, LocalVidoeGroupRequest>) -> LocalMediaProviderBuilder {
        self.localVideoGroupSupplier = MediaGroupSupplier(mediaGroupCollector: collector)
        return self
    }

    func build() -> LocalMediaProvider {
        
        if localVideoSupplier == nil{
            self.localVideoSupplier = MediaSupplierBuilder<LocalVideoMedia, LocalVideoRequest>()
                .setMediaCollector(LocalVideoCollector())
                .build()
        }
        
        if localVideoGroupSupplier == nil{
            self.localVideoGroupSupplier = MediaGroupSupplierBuilder<LocalVideoGroupMedia, LocalVidoeGroupRequest>()
                .setMediaGroupCollector(LocalVideoGroupCollector())
                .build()
        }
      
        return LocalMediaProvider(localVideoSupplier: self.localVideoSupplier!,
                                  localVideoGroupSupplier: self.localVideoGroupSupplier!)
        
    }
}
