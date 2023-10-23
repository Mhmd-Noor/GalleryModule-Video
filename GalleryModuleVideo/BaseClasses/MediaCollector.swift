//
//  MediaCollector.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 23/10/23.
//

import Foundation

class MediaCollector<M : Media, R: Any> {
    
    func getMediaData(_ request: R, _ isPaginated: Bool) -> MediaResult<M> {
        return MediaResult()
    }
}
