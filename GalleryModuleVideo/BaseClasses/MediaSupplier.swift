//
//  MediaSupplier.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 23/10/23.
//

import Foundation


class MediaSupplier<M: Media, R: Any> {
    
    var mediaCollector: MediaCollector<M,R>
    
    init(mediaCollector: MediaCollector<M,R>) {
        self.mediaCollector = mediaCollector
    }
    
    func getVideoData(_ request: R, _ isPaginated: Bool) -> MediaResult<M> {
        return mediaCollector.getMediaData(request, isPaginated)
    }
    
}


class MediaSupplierBuilder<M: Media, R: Any> {
    
    private var mediaCollector: MediaCollector<M,R>?
    
    func setMediaCollector(_ collector: MediaCollector<M,R>) -> MediaSupplierBuilder {
        self.mediaCollector = collector
        return self
    }
    
    func build() -> MediaSupplier<M,R> {
        guard let mediaCollector = self.mediaCollector else {
            self.mediaCollector = MediaCollector()
            fatalError("Cannot build MediaSupplier without a mediaCollector.")
        }
        return MediaSupplier(mediaCollector: mediaCollector)
    }
    
}
