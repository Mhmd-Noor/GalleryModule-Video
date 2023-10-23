//
//  MediaGroupSupplier.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 23/10/23.
//

import Foundation


class MediaGroupSupplier<M: Media, R: Any> {
    
    var mediaGroupCollector: MediaGroupCollector<M,R>
    
    init(mediaGroupCollector: MediaGroupCollector<M,R>) {
        self.mediaGroupCollector = mediaGroupCollector
    }
    
    func getVideoGroupData(_ request: R, _ isPaginated: Bool) -> MediaResult<M> {
        return mediaGroupCollector.getMediaCategoryData(request, isPaginated)
    }
    
}


class MediaGroupSupplierBuilder<M: Media, R: Any> {
    
    private var mediaGroupCollector: MediaGroupCollector<M,R>?
    
    func setMediaGroupCollector(_ collector: MediaGroupCollector<M,R>) -> MediaGroupSupplierBuilder {
        self.mediaGroupCollector = collector
        return self
    }
    
    func build() -> MediaGroupSupplier<M,R> {
        guard let mediaGroupCollector = self.mediaGroupCollector else {
            self.mediaGroupCollector = MediaGroupCollector()
            fatalError("Cannot build MediaGroupSupplier without a mediaGroupCollector.")
        }
        return MediaGroupSupplier(mediaGroupCollector: mediaGroupCollector)
    }
    
}
